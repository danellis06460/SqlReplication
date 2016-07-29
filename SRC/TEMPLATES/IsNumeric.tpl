<CODEGEN_FILENAME>IsNumeric.dbl</CODEGEN_FILENAME>
;//*****************************************************************************
;//
;// Title:      IsNumeric.tpl
;//
;// Description:Template to generate a subroutine that determines whether the
;//             data in an alpha variable represents a numeric value.
;//
;// Author:     Steve Ives, Synergex Professional Services Group
;//
;// Copyright   � 2009 Synergex International Corporation.  All rights reserved.
;//
;;*****************************************************************************
;;
;; File:        IsNumeric.dbl
;;
;; Type:        Subroutine (IsNumeric)
;;
;; Description: Determines whether the data in an alpha variable represents a
;;              numeric value.
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

namespace <NAMESPACE>

    function IsNumeric, boolean
        required in valueToTest, a
    proc
        try
        begin
            data number, d28.10
            number = valueToTest
            freturn true
        end
        catch (ex)
        begin
            freturn false
        end
        endtry
    endfunction

endnamespace
