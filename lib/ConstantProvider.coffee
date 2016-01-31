AbstractProvider = require './AbstractProvider'

module.exports =

##*
# Provides code navigation for global constants.
##
class ConstantProvider extends AbstractProvider
    ###*
     * @inheritdoc
    ###
    hoverEventSelectors: '.constant.other.php'

    ###*
     * @inheritdoc
    ###
    clickEventSelectors: '.constant.other.php'

    ###*
     * Convenience method that returns information for the specified term.
     *
     * @param {TextEditor} editor
     * @param {Point}      bufferPosition
     * @param {string}     term
    ###
    getInfoFor: (editor, bufferPosition, term) ->
        constants = @service.getGlobalConstants()

        return null unless constants and term of constants
        return null unless constants[term].filename

        return constants[term]

    ###*
     * @inheritdoc
    ###
    isValid: (editor, bufferPosition, term) ->
        return if @getInfoFor(editor, bufferPosition, term)? then true else false

    ###*
     * @inheritdoc
    ###
    gotoFromWord: (editor, bufferPosition, term) ->
        info = @getInfoFor(editor, bufferPosition, term)

        if info?
            atom.workspace.open(info.filename, {
                initialLine    : (info.startLine - 1),
                searchAllPanes : true
            })
