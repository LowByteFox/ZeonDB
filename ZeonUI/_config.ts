import lume from "lume/mod.ts";

const site = lume();
site.copy([".js", ".css"], (file) => file);

export default site;
