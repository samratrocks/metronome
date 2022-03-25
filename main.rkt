#lang racket/gui

(require rsound)

; Metronome for racket using gui


;; Logic section
(define (get-tick x)
  "Get tick at given times to call a function." x)


(define (do-something)
  (write "something"))


(define (play-ding)
  (play ding))


(define (create-timer callback) (new timer%
     [notify-callback callback]))


(define a-timer (create-timer play-ding))


(define (calculate-time-for-timer bpm)
  (* 1000 (/ bpm 60)))


(define (start-metronome bpm)
  (send a-timer start (calculate-time-for-timer bpm)))


(define (stop-metronome)
  (send a-timer stop))


;; GUI Section
(define metronome-gui-frame (new frame% [label "Main Window"]))


(new button%
     [parent  metronome-gui-frame]
     [label "Start"]
     [callback (lambda (button button-event) (start-metronome 60))])

(new button%
     [parent  metronome-gui-frame]
     [label "Stop"]
     [callback (lambda (button button-event) (stop-metronome))])
 
(send  metronome-gui-frame show #t)
