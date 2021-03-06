ADD_TEST([test-delim-space], [[
	ERROR="unexpected argument '--opt=something'" $(REVERSE) $< --opt=something
	$< --opt something | grep -q 'OPT_S=something,'
	ERROR="unexpected argument '--add=three'" $(REVERSE) $< -a one --add two --add=three
	$< -a one --add two | grep -q 'OPT_REP=one two,'
]])

ADD_TEST([test-delim-equals], [[
	ERROR="unexpected argument '--opt'" $(REVERSE) $< --opt something
	$< --opt=something | grep -q 'OPT_S=something,'
	ERROR="unexpected argument '--add'" $(REVERSE) $< -a one --add two --add=three
	$< -a one --add=two | grep -q 'OPT_REP=one two,'
]])

ADD_TEST([test-delim-both], [[
	$< --opt something | grep -q 'OPT_S=something,'
	$< --opt=something | grep -q 'OPT_S=something,'
	$< -a one --add two --add=three | grep -q 'OPT_REP=one two three'
]])
