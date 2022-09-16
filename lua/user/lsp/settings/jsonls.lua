return {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
          url = 'http://json.schemastore.org/tsconfig',
        },
      },
    },
  },
}
