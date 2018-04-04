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

if [ -z "${versioner_major_number}" ] ; then
  versioner_major_number="1"
fi

if [ -z "${versioner_minor_number}" ] ; then
  versioner_minor_number="0"
fi

if ! [[ ${versioner_major_number} =~ ^[0-9]+$ ]] ; then
   echo "ERROR: versioner_major_number parameter must be an integer.  Leave blank to default to 1." >&2; exit 1
fi

echo "Updating versions..."
echo "  major:    ${versioner_major_number}"
echo "  minor:    ${versioner_minor_number}"
echo "  build:    ${versioner_build_number}"
echo "  revision: ${versioner_revision_number}"

find . -name AssemblyInfo.cs -type f -exec sed -i '.bak'  "s/AssemblyVersion(\"[0-9\.\*]*/AssemblyVersion(\"${versioner_major_number}.${versioner_minor_number}.${versioner_build_number}.${versioner_revision_number}/" {} +
find . -name '*.nuspec' -type f -exec sed -i '.bak'  "s/version\>[0-9\.]*/version>${versioner_major_number}.${versioner_minor_number}.${versioner_build_number}/" {} +
find . -name '*.csproj' -type f -exec sed -i '.bak'  "s/PackageVersion\>[0-9\.]*/PackageVersion>${versioner_major_number}.${versioner_minor_number}.${versioner_build_number}/" {} +

exit 0
