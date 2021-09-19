# -*- vim: set noet fdm=marker filetype=make: -*-
# -*- coding: utf-8 -*-
#  Copyright (C) 2010 VimIM Team.
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Project Info {{{1
PROJECT_FULL_NAME = VimIM Data Project
PROJECT_NAME = vimim-data
COPYRIGHT = Copyright (C) 2010 VimIM Team.
PROJECT_URL = http://code.google.com/p/vimim-data/
REPOSITORY_URL = http://vimim-data.googlecode.com/svn/
NEWS_GROUP = http://groups.google.com/group/vimim
ISSUE_TRACKING = http://code.google.com/p/vimim-data/issues/list
DOWNLOAD = http://code.google.com/p/vimim-data/downloads/list

# ----------------------------------------------------------------------
# Directories {{{1
ROOT_DIR ?= $(CURDIR)
BUILD_DIR := ${ROOT_DIR}/build
DATA_DIR := ${ROOT_DIR}/data
DIST_DIR := ${ROOT_DIR}/dist

# Commands {{{1
CAT	= cat
CD	= cd
CP	= cp
ECHO	= echo
GREP	= grep
MKDIR	= mkdir
SHELL	= /bin/sh
SCM	= svn
TAR	= tar
UPLOADER = ${ROOT_DIR}/googlecode_upload.py

# Variables {{{1
VERSION := $(shell ${SCM} info|${GREP} Revision)
SUMMARY := ${ROOT_DIR}/SUMMARY
DICT_EXT := txt
GZIP_EXT := txt.gz
BZIP2_EXT := txt.bz2

GOOGLECODE_ACCOUNT_FILE = ~/.googlecode-password
# This is a file contains your google code account info in two fields separated by space:
# yourname your-google-code-password
#
# You can get your google code password here:
# https://code.google.com/hosting/settings
# Please make it readable only by yourself
# e.g. $ chmod 0400 ~/.googlecode-password
GOOGLE_CODE_USERNAME := $(word 1, $(shell $(CAT) ${GOOGLECODE_ACCOUNT_FILE}))
GOOGLE_CODE_PASSWORD := $(word 2, $(shell $(CAT) ${GOOGLECODE_ACCOUNT_FILE}))

# Sources {{{1
DATA_ALL := $(wildcard ${DATA_DIR}/*.${DICT_EXT})

# Outputs {{{1
TMP_ = $(addprefix ${BUILD_DIR}/, $(notdir ${DATA_ALL}))
GZIP_ALL := $(TMP_:%.${DICT_EXT}=%.${GZIP_EXT})
BZIP2_ALL := $(TMP_:%.${DICT_EXT}=%.${BZIP2_EXT})
UPLOAD_FILES := $(wildcard ${DIST_DIR}/*)

# Flags {{{1
GZIP_FLAGS := -z
BZIP2_FLAGS := -j
UPLOADER_FLAGS := -l "Type-Archive" -p ${PROJECT_NAME} -u ${GOOGLE_CODE_USERNAME} -w ${GOOGLE_CODE_PASSWORD}

# Pattern Rules {{{1
${BUILD_DIR}/%.${GZIP_EXT} : ${DATA_DIR}/%.${DICT_EXT}
	@$(CD) ${DATA_DIR} && $(TAR) ${GZIP_FLAGS} -cf $@ $(notdir $<)

${BUILD_DIR}/%.${BZIP2_EXT} : ${DATA_DIR}/%.${DICT_EXT}
	@$(CD) ${DATA_DIR} && $(TAR) ${BZIP2_FLAGS} -cf $@ $(notdir $<)

$(notdir ${DIST_DIR})/%.${GZIP_EXT} : ${BUILD_DIR}/%.${GZIP_EXT} ${BUILD_DIR} ${DIST_DIR}
	$(CP) $< $@

$(notdir ${DIST_DIR})/%.${BZIP2_EXT} : ${BUILD_DIR}/%.${BZIP2_EXT} ${BUILD_DIR} ${DIST_DIR}
	$(CP) $< $@

# Targets {{{1
# General {{{2
.PHONY : default
default : help

# Target license {{{3
.PHONY : license
license :
	@$(CAT) COPYING

# Target version {{{3
.PHONY : version
version :
	@$(ECHO) "[*] ${PROJECT_FULL_NAME} Distribution - ${VERSION}"

# Target help {{{3
.PHONY : help
help :
	@$(ECHO) "${PROJECT_FULL_NAME} Distribution"
	@$(ECHO) "URL: ${PROJECT_URL}"
	@$(ECHO)
	@$(ECHO) "[Info]"
	@$(ECHO) "  license      : display ${PROJECT_FULL_NAME} Distribution license"
	@$(ECHO) "  version      : display ${PROJECT_FULL_NAME} Distribution version number"
	@$(ECHO) "  help         : display this help text"
	@$(ECHO) "  about        : display more information about ${PROJECT_NAME}"
	@$(ECHO) "  status       : display version no., list sources and output files, etc."
	@$(ECHO)
	@$(ECHO) "[Build]"
	@$(ECHO) "  all          : pack all data files into gzip and bzip2 archives"
	@$(ECHO) "  gzip         : pack all data files into gzip archives"
	@$(ECHO) "  bzip2        : pack all data files into bzip2 archives"
	@$(ECHO)
	@$(ECHO) "[Distribution]"
	@$(ECHO) "  dist         : prepare gzip and bzip2 archives for distribution"
	@$(ECHO) "  dist-gzip    : prepare gzip archives for distribution"
	@$(ECHO) "  dist-bzip2   : prepare bzip2 archives for distribution"
	@$(ECHO) 
	@$(ECHO) "[Upload]"
	@$(ECHO) "  upload       : upload archives in distribution dir. to google code"
	@$(ECHO) "                 run 'make howto' for more information"
	@$(ECHO)
	@$(ECHO) "[Clean Up]"
	@$(ECHO) "  clean        : remove all intermediate files"
	@$(ECHO) "  cleanall     : remove all intermediate files and output files"
	@$(ECHO)

# Target about {{{3
.PHONY : about
about :
	@$(ECHO) "Project Name:"
	@$(ECHO) "    ${PROJECT_FULL_NAME}"
	@$(ECHO) "    ${COPYRIGHT}"
	@$(ECHO)
	@$(ECHO) "License: See file COPYING for license or 'make license'"
	@$(ECHO)
	@$(ECHO) "Project URL:"
	@$(ECHO) "    ${PROJECT_URL}"
	@$(ECHO) "Source Code Repository:"
	@$(ECHO) "    ${REPOSITORY_URL}"
	@$(ECHO) "News Group:"
	@$(ECHO) "    ${NEWS_GROUP}"
	@$(ECHO) "Issue Tracking:"
	@$(ECHO) "    ${ISSUE_TRACKING}"
	@$(ECHO) "Download:"
	@$(ECHO) "    ${DOWNLOAD}"
	@$(ECHO)

# Target howto {{{3
.PHONY : howto
howto :
	@$(ECHO)
	@$(ECHO) " To avoid entering username and password again and agian,"
	@$(ECHO) " please create a file under your home called .googlecode-password"
	@$(ECHO) " with your google code account's username and password in it."
	@$(ECHO) " 'make upload' will then get your username and password by reading it."
	@$(ECHO)
	@$(ECHO) " Please put username and password on the same line, separated by space."
	@$(ECHO) " Username"
	@$(ECHO) "     Username is the part that before @"
	@$(ECHO) "     for example, if you login your account with joe.schmoe@example.com"
	@$(ECHO) "     then joe.schmoe is the username"
	@$(ECHO) " Password"
	@$(ECHO) "     Password is NOT the same as the one you use to login"
	@$(ECHO) "     Get your password here: https://code.google.com/hosting/settings"
	@$(ECHO) "     It should be a string of text with 12 characters."
	@$(ECHO) "     for example, A1B2C3D4E5F6"
	@$(ECHO)
	@$(ECHO) " With the above examples, the file .googlecode-password should look like:"
	@$(ECHO) "joe.schmoe A1B2C3D4E5F6"
	@$(ECHO)
	@$(ECHO) " IMPORTANT: this file contains your account password,"
	@$(ECHO) "            remember to make it readable only by yourself."
	@$(ECHO) "            e.g. $$ chmod 0400 ~/.googlecode-password"

# Target status {{{3
.PHONY : status st stat
st : status
stat : status
status :
	@$(ECHO) "${PROJECT_FULL_NAME} Distribution"
	@$(ECHO) "[Root Dir] '${ROOT_DIR}'"
	@$(ECHO) "[Data Dir] '${DATA_DIR}'"
	@$(ECHO) "[Build Dir] '${BUILD_DIR}'"
	@$(ECHO) "[Distribution Dir] '${DIST_DIR}'"
	@$(ECHO)
	@$(ECHO) "[Input Files]"
	@$(ECHO) "* VimIM Data Files *"
	@$(ECHO) "$(notdir ${DATA_ALL})"
	@$(ECHO)
	@$(ECHO) "[Output Files]"
	@$(ECHO) "* Gzip Tarballs *"
	@$(ECHO) "$(notdir ${GZIP_ALL})"
	@$(ECHO)
	@$(ECHO) "* Bzip2 Tarballs *"
	@$(ECHO) "$(notdir ${BZIP2_ALL})"
	@$(ECHO)
	@$(ECHO) "[Upload Files]"
	@$(ECHO) "$(notdir ${UPLOAD_FILES})"

# Packaging {{{2
.PHONY : all
all : gzip bzip2

# Target gzip {{{3
.PHONY : gzip gz
gz : gzip
gzip : init ${GZIP_ALL}
	@$(ECHO) -n "[+] Generating gzip tarballs(s) ... "
	@if [ -n "${GZIP_ALL}" ]; then \
		$(ECHO) "done." && \
		$(ECHO) "[.] Generated gzip tarball(s) in '${BUILD_DIR}':" && \
		$(ECHO) "$(notdir ${GZIP_ALL})"; \
	else \
		$(ECHO) "nothing generated."; \
	fi

# Target bzip2 {{{3
.PHONY : bzip2 bz2
bz2 : bzip2
bzip2 : init ${BZIP2_ALL}
	@$(ECHO) -n "[+] Generating bzip2 tarballs(s) ... "
	@if [ -n "${BZIP2_ALL}" ]; then \
		$(ECHO) "done." && \
		$(ECHO) "[.] Generated bzip2 tarball(s) in '${BUILD_DIR}':" && \
		$(ECHO) "$(notdir ${BZIP2_ALL})"; \
	else \
		$(ECHO) "nothing generated."; \
	fi
# Distribution {{{2
.PHONY : dist
dist: dist-gzip dist-bzip2

# Target dist-gzip {{{3
.PHONY : dist-gzip dist-gz
dist-gz : dist-gzip
dist-gzip : init-dist gzip
	@if [ -n "${GZIP_ALL}" ]; then \
		$(ECHO) -n "[+] Copying generated gzip tarball(s) into '${DIST_DIR}' ... " && \
		$(CP) ${GZIP_ALL} ${DIST_DIR} && \
		$(ECHO) "done." && \
		$(ECHO) "[.] Prepared gzip tarball(s) in '${DIST_DIR}':" && \
		$(ECHO) "$(notdir ${GZIP_ALL})"; \
	fi

# Target dist-bzip2 {{{3
.PHONY : dist-bzip2 dist-bz2
dist-bz2 : dist-bzip2
dist-bzip2 : init-dist bzip2
	@if [ -n "${BZIP2_ALL}" ]; then \
		$(ECHO) -n "[+] Copying generated bzip2 tarball(s) into '${DIST_DIR}' ... " && \
		$(CP) ${BZIP2_ALL} ${DIST_DIR} && \
		$(ECHO) "done." && \
		$(ECHO) "[.] Prepared bzip2 tarball(s) in '${DIST_DIR}':" && \
		$(ECHO) "$(notdir ${BZIP2_ALL})"; \
	fi

# Uploading {{{2
# Target upload
.PHONY : upload up
up : upload
upload : ${UPLOAD_FILES}
	@if [ -n "${UPLOAD_FILES}" ]; then \
		$(CD) ${DIST_DIR} && \
		for file in *; do \
			$(ECHO) "[>] Uploading file '$${file}'" && \
			$(UPLOADER) -s "`grep $${file} ${SUMMARY}` ${VERSION}" ${UPLOADER_FLAGS} $${file} && \
			$(ECHO) "[.] Done."; \
		done \
	else \
		$(ECHO) "nothing to be uploaded."; \
	fi

# Clean up {{{2
# Target clean {{{3
.PHONY : clean
clean :
	@$(ECHO) -n "[-] Removing temporary files in '${BUILD_DIR}' ... "
	@$(RM) $(addprefix ${BUILD_DIR}/, *)
	@$(ECHO) "done."

# Target cleanall {{{3
.PHONY : cleanall clean-all
clean-all : cleanall
cleanall : clean
	@$(ECHO) -n "[-] Removing temporary directories ... "
	@$(RM) -r ${BUILD_DIR}
	@$(ECHO) "done."
	@$(ECHO) -n "[-] Removing generated tarball(s) and dist directory ... "
	@$(RM) -r ${DIST_DIR}
	@$(ECHO) "done."

# Internal Targets {{{2
${BUILD_DIR} :
	@$(ECHO) -n "[+] Creating directory '${BUILD_DIR}' ... "
	@$(MKDIR) ${BUILD_DIR}
	@$(ECHO) "done."
${DIST_DIR} :
	@$(ECHO) -n "[+] Creating directory '${DIST_DIR}' ... "
	@$(MKDIR) ${DIST_DIR}
	@$(ECHO) "done."

.PHONY : init
init : ${BUILD_DIR} 

.PHONY : init-dist
init-dist : ${DIST_DIR}
