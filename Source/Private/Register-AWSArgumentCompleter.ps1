# Register Argument completer for AWS CLI in PowerShell.
# Based on AWS Recommendations: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-windows

Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    aws_completer.exe | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
    Remove-Item Env:\COMP_LINE
    Remove-Item Env:\COMP_POINT
}