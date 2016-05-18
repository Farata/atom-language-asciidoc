describe 'typographic quotes', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-asciidoc'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'source.asciidoc'

  # convenience function during development
  debug = (tokens) ->
    console.log(JSON.stringify tokens, null, ' ')

  it 'parses the grammar', ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe 'source.asciidoc'

  describe 'Should tokenizes typographic double quotes when', ->

    it 'in a simple phrase', ->
      {tokens} = grammar.tokenizeLine 'foo "`double-quoted`" foo'
      expect(tokens).toHaveLength 5
      expect(tokens[0]).toEqualJson value: 'foo ', scopes: ['source.asciidoc']
      expect(tokens[1]).toEqualJson value: '"`', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[2]).toEqualJson value: 'double-quoted', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc']
      expect(tokens[3]).toEqualJson value: '`"', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[4]).toEqualJson value: ' foo', scopes: ['source.asciidoc']

    it 'has role', ->
      {tokens} = grammar.tokenizeLine 'foo [bar]"`double-quoted`" foo'
      expect(tokens).toHaveLength 6
      expect(tokens[0]).toEqualJson value: 'foo ', scopes: ['source.asciidoc']
      expect(tokens[1]).toEqualJson value: '[bar]', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'markup.meta.attribute-list.asciidoc']
      expect(tokens[2]).toEqualJson value: '"`', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[3]).toEqualJson value: 'double-quoted', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc']
      expect(tokens[4]).toEqualJson value: '`"', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[5]).toEqualJson value: ' foo', scopes: ['source.asciidoc']

  describe 'Should tokenizes typographic single quotes when', ->

    it 'in a simple phrase', ->
      {tokens} = grammar.tokenizeLine 'foo \'`single-quoted`\' foo'
      expect(tokens).toHaveLength 5
      expect(tokens[0]).toEqualJson value: 'foo ', scopes: ['source.asciidoc']
      expect(tokens[1]).toEqualJson value: '\'`', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[2]).toEqualJson value: 'single-quoted', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc']
      expect(tokens[3]).toEqualJson value: '`\'', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[4]).toEqualJson value: ' foo', scopes: ['source.asciidoc']

    it 'has role', ->
      {tokens} = grammar.tokenizeLine 'foo [bar]\'`single-quoted`\' foo'
      expect(tokens).toHaveLength 6
      expect(tokens[0]).toEqualJson value: 'foo ', scopes: ['source.asciidoc']
      expect(tokens[1]).toEqualJson value: '[bar]', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'markup.meta.attribute-list.asciidoc']
      expect(tokens[2]).toEqualJson value: '\'`', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[3]).toEqualJson value: 'single-quoted', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc']
      expect(tokens[4]).toEqualJson value: '`\'', scopes: ['source.asciidoc', 'markup.other.typographic-quotes.asciidoc', 'constant.other.symbol.asciidoc']
      expect(tokens[5]).toEqualJson value: ' foo', scopes: ['source.asciidoc']
