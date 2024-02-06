let dylib: unknown;
const text_encoder = new TextEncoder();

export function initZeonDB(path: string): void {
	dylib = Deno.dlopen(
		path,
		{
			"ZeonAPI_Connection_create":
			{
				parameters: ["buffer", "u16"],
				result: "pointer",
				nonblocking: true
			},
			"ZeonAPI_Connection_destroy":
			{
				parameters: ["pointer"],
				result: "void",
				nonblocking: true
			},
			"ZeonAPI_Connection_is_up":
			{
				parameters: ["pointer"],
				result: "void",
			},
			"ZeonAPI_Connection_get_error":
			{
				parameters: ["pointer"],
				result: "buffer",
			},
			"ZeonAPI_Connection_get_buffer":
			{
				parameters: ["pointer"],
				result: "buffer",
			},
			"ZeonAPI_Connection_auth":
			{
				parameters: ["pointer", "buffer", "buffer"],
				result: "i32",
				nonblocking: true
			},
			"ZeonAPI_Connection_exec":
			{
				parameters: ["pointer", "buffer"],
				result: "i32",
				nonblocking: true
			},
		},
	);
}

interface ZeonResult {
	ok: boolean,
	value: unknown,
	msg: string,
}

interface ZeonKey {
	path: string,
	version: string,
	index: number,
	next?: ZeonKey,
	setVersion: (version: string) => ZeonKey,
	setIndex: (index: number) => ZeonKey,
	chainWith: (key: ZeonKey) => ZeonKey,
	stringify: () => string,
}

function Key(pth: string): ZeonKey {
	let path = pth;
	let version = "";
	let index = -1;

	return {
		path,
		version,
		index,
		next: null,

		setVersion: function(version: string) {
			this.version = version;
			return this;
		},

		setIndex: function(index: number) {
			if (index < 0) {
				throw "Index cannot be less than 0!"
			}
			this.index = index;
			return this;
		},

		chainWith: function(next: ZeonKey) {
			this.next = next;
			return this;
		},

		stringify: function() {
			let str = this.path;
			if (this.version.length > 0) {
				str += `@${this.version}`
			}

			if (this.index > -1) {
				str += `[${this.index}]`
			}

			if (this.next) {
				str += `.${this.next.stringify()}`
			}

			return str;
		}
	};
}

export class ZeonDB {
	private connection: unknown;

	constructor(ip: string, port: number) {
		return Promise.resolve(
		    dylib.symbols.ZeonAPI_Connection_create(
		        text_encoder.encode(ip + "\0"), port)
		).then(connection => {
			this.connection = connection;
			return this;
		});
	}

	async login(username: string, password: string): boolean {
		const u = text_encoder.encode(username + "\0");
		const p = text_encoder.encode(password + "\0");
		return (await dylib.symbols.ZeonAPI_Connection_auth(
		    this.connection, u, p)) == 1;
	}

	get_error(): string {
		const ret = new Deno.UnsafePointerView(
			    dylib.symbols.ZeonAPI_Connection_get_error(
			    this.connection
			));
		return ret.getCString();
	}

	get_output(): string {
		const ret = new Deno.UnsafePointerView(
			    dylib.symbols.ZeonAPI_Connection_get_buffer(
			    this.connection
			));
		return ret.getCString();
	}

	async set(key: Key, value: unknown): ZeonResult {
		const res = await
		    this.exec(`set ${key.stringify()} ${JSON.stringify(value)}`);
		if (res) {
			return {
				ok: res,
				value: this.get_output(),
			};
		}

		return {
			ok: res,
			msg: this.get_error(),
		};
	}

	async get(key: Key): ZeonResult {
		const res = await this.exec(`get ${key.stringify()}`);
		if (res) {
			return {
				ok: res,
				value: JSON.parse(this.get_output()),
			};
		}

		return {
			ok: res,
			msg: this.get_error(),
		};
	}

	private async exec(code: string): boolean {
		const c = text_encoder.encode(code + "\0");
		return (await dylib.symbols.ZeonAPI_Connection_exec(
		    this.connection, c)) == 1;
	}

	async disconnect() {
		await dylib.symbols.ZeonAPI_Connection_destroy(
		    this.connection
		);
	}
}

initZeonDB("../build/libZeonCAPI.so");

function create_blog(title, author, ...tags) {
	return {
		title,
		author,
		tags
	};
}

const db = await (new ZeonDB("127.0.0.1", 6748));

// cached key
const docRef = Key("users").setVersion("theo");

const data = [
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
	create_blog("blog", "amogus", "this will kill my pc for sure".split(" ")),
];

if (await db.login("dummy", "1234")) {
	let res = await db.set(docRef, data);
	if (!res.ok) {
		console.error(res.msg);
		Deno.exit(1);
	}

	res = await db.get(docRef);
	if (res.ok) {
		console.log(res.value);
	} else {
		console.error(res.msg);
	}
} else {
	console.log(db.get_error());
}

await db.disconnect();
