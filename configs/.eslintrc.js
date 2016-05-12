{
  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true,
      "experimentalObjectRestSpread": true
    }
  },

  "env": {
    "browser": true,
    "node": true,
    "es6": true,
    "worker": true,
    "mocha": true,
    "serviceworker": true
  },

  "rules": {
    "indent": ["error", 2, { "VariableDeclarator": { "var": 2, "let": 2, "const": 3 } }],
    "quotes": ["error", "single", { "avoidEscape": true, "allowTemplateLiterals": true }],
    "block-spacing": "error",
    "brace-style": "error",
    "curly": "error",
    "no-irregular-whitespace": "error",
    "no-console": ["error", { allow: ["warn", "error"] }],
    "require-yield": "error"
  }
}
