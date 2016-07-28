<CODEGEN_FILENAME>LastRecordCache.dbl</CODEGEN_FILENAME>
;//*****************************************************************************
;//
;// Title:      LastRecordCache.tpl
;//
;// Description:Template to generate a class to track the data of the last
;//             record that was read from or written to each channel.
;//
;// Author:     Steve Ives, Synergex Professional Services Group
;//
;// Copyright   � 2009 Synergex International Corporation.  All rights reserved.
;//
;;*****************************************************************************
;;
;; File:        LastRecordCache.dbl
;;
;; Type:        Class (LastRecordCache)
;;
;; Description: Track the data of the last record that was read from or written
;;              to each channel.
;;
;; Author:      <AUTHOR>
;;
;;*****************************************************************************
;;
;; Copyright (c) 2009, Synergex International, Inc.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; * Redistributions of source code must retain the above copyright notice,
;;   this list of conditions and the following disclaimer.
;;
;; * Redistributions in binary form must reproduce the above copyright notice,
;;   this list of conditions and the following disclaimer in the documentation
;;   and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;;*****************************************************************************
;; WARNING: THIS CODE WAS CODE GENERATED AND WILL BE OVERWRITTEN IF CODE
;;          GENERATION IS RE-EXECUTED FOR THIS PROJECT.
;;*****************************************************************************

import Synergex.SynergyDE.IOExtensions
import Synergex.SynergyDE.Select

namespace <NAMESPACE>

    public static class LastRecordCache

        private static cache, [#]string

        static method LastRecordCache
        proc
            cache = new string[1024]
        endmethod

        public static method Init, void
            required in aChannel, int
            endparams
        proc
            cache[aChannel] = ""
        endmethod

        public static method Update, void
            required in aChannel, int
            required in aData, string
            endparams
        proc
            cache[aChannel] = aData
        endmethod

        public static method HasChanged, boolean
            required in aChannel, int
            required in aData, string
            endparams
        proc
            mreturn (aData != cache[aChannel])
        endmethod

        public static method Retrieve, string
            required in aChannel, int
        proc
            mreturn cache[aChannel]
        endmethod

        public static method Clear, void
            required in aChannel, int
        proc
            cache[aChannel] = ^null
        endmethod
    endclass

endnamespace
