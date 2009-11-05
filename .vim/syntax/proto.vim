" Copyright (c) 2005 Google, Inc.
" Vim syntax file for protocol buffer and Stubby
" 
" Documentation:
" * Protocol buffers
"   https://www/eng/designdocs/infrastructure/protocol-buffer.html
" * Stubby: the new RPC system
"   https://www/eng/designdocs/infrastructure/stubby.html
"
" Author:   Misha Brukman <mbrukman@google.com>
" Modified: 2005-08-02
"
" Usage:
"
" 1. % cp proto.vim ~/.vim/syntax/
" 2. Add the following to ~/.vimrc:
" 
" augroup filetype
"   au! BufRead,BufNewFile *.proto         setfiletype proto
"   au! BufRead,BufNewFile *.protodevel    setfiletype proto
" augroup end

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

syn keyword pbStorageClass parsed 
syn keyword pbKeyword      package class
syn keyword pbStructure    group message 
syn keyword pbRepeat       required optional repeated 
syn keyword pbDefault      default

syn keyword pbType double float int64 uint64 int32 fixed32 fixed64 
syn keyword pbType bool boolean string
syn keyword pbBool true false
syn keyword pbTypedef enum

setlocal iskeyword+=+
syn keyword pbLangSpec c++ c++header c# java python sawzall

syn match   pbInt     /-\?\<\d\+\>/
syn match   pbInt     /\<0[xX]\x+\>/
syn match   pbFloat   /\<-\?\d*\(\.\d*\)\?/
syn keyword pbTodo    TODO FIXME contained
syn match   pbNext    /[Nn]ext \([Aa]vailable \)\?[Tt]ag/ contained
syn match   pbNext    /next available tag/
" TODO(mbrukman): Add C-style comments 
" (non-trivial; see /usr/share/vim/vim63/syntax/c.vim)
syn match   pbComment /\/\/.*$/ contains=pbTodo,pbNext
syn region  pbString  start=/"/ skip=/\\"/ end=/"/

" TODO(mbrukman): Is this complete support for services and RPC?
syn keyword pbKeyword       service rpc returns option
syn keyword pbOption        dplopts noindex snippets flatten
syn keyword pbMethodOption  deadline duplicate_suppression
syn keyword pbMethodOption  protocol client_logging server_logging
syn keyword pbMethodOption  fail_fast
syn keyword pbNetProto      tcp udp
syn keyword pbSecurity      security_level none integrity privacy_and_integrity
syn keyword pbSecurity      strong_privacy_and_integrity
syn keyword pbServiceOption failure_detection_delay

if version >= 508 || !exists("did_proto_syn_inits")
  if version < 508
    let did_proto_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " Protocol buffer
  HiLink pbStorageClass StorageClass
  HiLink pbKeyword      Keyword
  HiLink pbStructure    Structure
  HiLink pbRepeat       Repeat
  HiLink pbDefault      Keyword
  HiLink pbLangSpec     Include
  HiLink pbType         Type
  HiLink pbTypedef      Typedef
  HiLink pbBool         Boolean
  HiLink pbInt          Number
  HiLink pbFloat        Float
  HiLink pbTodo         Todo
  HiLink pbNext         Todo
  HiLink pbComment      Comment
  HiLink pbString       String

  " Stubby services and RPC
  HiLink pbOption        Keyword
  HiLink pbMethodOption  Keyword
  HiLink pbNetProto      Keyword
  HiLink pbSecurity      Keyword
  HiLink pbServiceOption Keyword

  delcommand HiLink
endif
 
let b:current_syntax = "proto"
