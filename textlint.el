;;; textlint.el --- bla bla about textlint -*- coding: utf-8 -*-

;; Copyright (C) 2011, Damien Cassou <damien.cassou@gmail.com>

;; Author: Damien Cassou <damien.cassou@gmail.com>
;; Maintainer: Damien Cassou <damien.cassou@gmail.com>
;; Created: 2 Sep 2011
;; Version: 0.8

;; This file is not currently part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; bla bla

;;; Code:

(defgroup textlint nil
  "Controlling TextLint (http://scg.unibe.ch/research/textlint) from Emacs."
  :prefix "textlint-"
  :group 'tools)

(defcustom textlint-location-textlint
  "~/.emacs.d/el-get/textlint"
  "The path to the textlint.bash Bash script."
  :group 'textlint
  :type '(directory))

(defun textlint-location-vm-from-textlint-location ()
  (concat textlint-location-textlint "/Linux32/pharo"))

(defcustom textlint-location-vm
  'textlint-location-vm-from-textlint-location
  "Indicates where the Smalltalk Virtual Machine can be found.
The value is either a function which will be executed to get the
VM location or a file. The default for the function is
`textlint-location-vm-from-textlint-location` which returns the
location of the VM based on the location of TextLint as indicated
by `textlint-location-textlint`."
  :group 'textlint
  :type '(choice (function :value textlint-location-vm-from-textlint-location) (file :must-match t)))

(defun textlint-get-location-vm ()
  (expand-file-name (if (functionp textlint-location-vm)
			(funcall textlint-location-vm)
		      textlint-location-vm)))

(defun textlint-location-image-from-textlint-location ()
  (concat textlint-location-textlint "/TextLint.tmbundle/Support/TextLint.image"))

(defcustom textlint-location-image
  'textlint-location-image-from-textlint-location
  "Indicates where the Smalltalk Image for TextLint can be found.
The value is either a function which will be executed to get the
image location or a file. The default for the function is
`textlint-location-image-from-textlint-location` which returns the
location of the image based on the location of TextLint as indicated
by `textlint-location-textlint`."
  :group 'textlint
  :type '(choice (function :value textlint-location-image-from-textlint-location) (file :must-match t)))

(defun textlint-get-location-image ()
  (expand-file-name (if (functionp textlint-location-image)
			(funcall textlint-location-image)
		      textlint-location-image)))

(defun textlint-get-location-script ()
  (expand-file-name (concat textlint-location-textlint "/textlint.bash")))

(defun textlint-run ()
  (interactive)
  (let ((filename (file-relative-name (buffer-file-name))))
    (compile (format "\"%s\" \"%s\" \"%s\" \"%s\""
		     (textlint-get-location-script)
		     filename
		     (textlint-get-location-vm)
		     (textlint-get-location-image)))))


;;; textlint.el ends here
