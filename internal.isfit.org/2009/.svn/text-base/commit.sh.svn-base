#!/bin/bash

# Automagically comments the line for url rewriting containing your username
# in .htaccess before committing, and reverts afterwards.

username=$(whoami)

from="RewriteBase /~$username/internal.isfit.org/public"
to="#RewriteBase /~$username/internal.isfit.org/public"

replace "$from" "$to" -- public/.htaccess

svn commit

replace "$to" "$from" -- public/.htaccess
