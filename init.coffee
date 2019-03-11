# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

# Relies on terminal-tab package, configured to launch
# C:\\Windows\\System32\\wsl.exe as shell path
terminalStarted = false
atom.commands.add 'atom-workspace', 'terminal:focus', ->
  atom.workspace.open('terminal-tab://') if !terminalStarted
  terminalStarted = true
  dock = atom.workspace.getBottomDock()
  if dock.isVisible()
    dock.hide()
  else
    dock.activate()
