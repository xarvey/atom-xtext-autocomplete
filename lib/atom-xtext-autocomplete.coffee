AtomXtextAutocompleteView = require './atom-xtext-autocomplete-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomXtextAutocomplete =
  atomXtextAutocompleteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomXtextAutocompleteView = new AtomXtextAutocompleteView(state.atomXtextAutocompleteViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomXtextAutocompleteView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-xtext-autocomplete:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomXtextAutocompleteView.destroy()

  serialize: ->
    atomXtextAutocompleteViewState: @atomXtextAutocompleteView.serialize()

  toggle: ->
    console.log 'AtomXtextAutocomplete was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
