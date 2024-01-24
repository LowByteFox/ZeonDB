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

	async auth(username: string, password: string): boolean {
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

	async set(key: string, value: unknown): ZeonResult {
		const res = await
		    this.exec(`set ${key} ${JSON.stringify(value)}`);
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

	async get(key: string): ZeonResult {
		const res = await this.exec(`get ${key}`);
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

const db = await (new ZeonDB("127.0.0.1", 6748));

if (await db.auth("theo", "paris")) {
	let res = await db.set('Deno', {
		je: {
			super: true
		}
	});
	if (!res.ok) {
		console.error(res.msg);
		Deno.exit(1);
	}
	res = await db.get("$");
	if (res.ok) {
		console.log(res.value);
	} else {
		console.error(res.msg);
	}
} else {
	console.log(db.get_error());
}

await db.disconnect();
