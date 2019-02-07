function which --description "Print location of command or source of fish function"
    set --local func_lines (functions $argv)
    
    if [ (count $func_lines) > 0 ]
        echo "fish function defined:"
        
        for func in $func_lines 
            echo $func
        end
    end

    set --local com_loc (command which $argv)

    if [ $com_loc ]
        echo ""
        echo "original command location:"
        echo $com_loc
    end
end
