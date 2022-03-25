#lang racket/gui

; Metronome for racket using gui
(require rsound)


;; Logic section
(define (do-something)
  (write "something"))


(define (play-ding)
  (play ding))


(define (create-timer callback) (new timer%
     [notify-callback callback]))


(define a-timer (create-timer play-ding))


(define (calculate-time-for-timer bpm)
  (exact-floor (* 1000 (/ bpm 60))))




;; GUI Section
(define metronome-gui-frame (new frame% [label "Main Window"]))

(define tempo-slider (new slider%
     [label "Tempo"]
     [min-value 40]
     [max-value 220]
     [parent metronome-gui-frame]
     [init-value 120]))

(new button%
     [parent  metronome-gui-frame]
     [label "Start"]
     [callback (lambda (button button-event) (start-metronome (parse-slider-value (send tempo-slider get-value))))])

(new button%
     [parent  metronome-gui-frame]
     [label "Stop"]
     [callback (lambda (button button-event) (stop-metronome))])
 
(send  metronome-gui-frame show #t)


(define (start-metronome bpm)
  (write (calculate-time-for-timer bpm))
  (send a-timer start (calculate-time-for-timer bpm)))


(define (stop-metronome)
  (send a-timer stop))

(define (parse-slider-value value)
  "Parses the value of the slider to an integer"
  ; For some reason slider gives back value in terms of (x * 50) / 3
  ; so we need to multiply by 3 and divide by 50
  (exact-floor (* 0.06 value)))