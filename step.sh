#!/bin/bash

# exit if a command fails
set -e

if ! [[ ${versioner_build_number} =~ ^[0-9]+$ ]] ; then
   echo "ERROR: versioner_build_number parameter must be an integer" >&2; exit 1
fi

if [ -z "${versioner_revision_number}" ] ; then
  versioner_revision_number="0"
fi

if ! [[ ${versioner_revision_number} =~ ^[0-9]+$ ]] ; then
   echo "ERROR: versioner_revision_number parameter must be an integer.  Leave blank to use zero." >&2; exit 1
fi

echo "Updating versions..."
echo "  build:    ${versioner_build_number}"
echo "  revision: ${versioner_revision_number}"

find . -name AssemblyInfo.cs -type f -exec sed -i '.bak'  "s/AssemblyVersion(\"[0-9\.\*]*/AssemblyVersion(\"1.0.${versioner_build_number}.${versioner_revision_number}/" {} +
find . -name '*.nuspec' -type f -exec sed -i '.bak'  "s/version\>[0-9\.]*/version>1.0.${versioner_build_number}/" {} +

exit 0