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
atom.commands.add 'atom-workspace', 'terminal:focus', ->
  dock = atom.workspace.getBottomDock()

  terminalStarted = "Terminal" in (item.getTitle() for item in dock.getPaneItems())
  atom.workspace.open('terminal-tab://') if !terminalStarted

  if dock.isVisible()
    dock.hide()
  else
    dock.activate()
