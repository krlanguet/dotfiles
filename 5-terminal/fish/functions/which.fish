function which --description "Print location of command or source of fish function"
    set --local func_lines (functions $argv)
    set --local com_loc (command which $argv)
    
    if test -n "$func_lines"
        echo "fish function defined:"
        for line in $func_lines
            echo $line
        end
    end

    if test -n "$func_lines" && test -n "$com_loc"
        echo ""
    end

    if test -n "$com_loc"
        echo "original command location:"
        echo $com_loc
    end
end
