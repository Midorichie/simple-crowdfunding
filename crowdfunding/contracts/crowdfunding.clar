(define-constant err-unauthorized (err u100))
(define-constant err-deadline-passed (err u101))
(define-constant err-goal-not-met (err u102))
(define-constant err-goal-met (err u103))
(define-constant err-zero-contribution (err u104))
(define-constant err-no-contribution (err u105))
(define-constant err-deadline-not-reached (err u106))
(define-constant err-already-initialized (err u110))
(define-constant err-transfer-failed (err u111))

(define-data-var manager principal tx-sender)
(define-data-var goal uint u0)
(define-data-var deadline uint u0)
(define-data-var total-raised uint u0)
(define-map contributions { contributor: principal } { amount: uint })

(define-data-var campaign-initialized bool false)

;; Create a crowdfunding campaign
(define-public (create-campaign (target uint) (end uint))
  (if (var-get campaign-initialized)
      err-already-initialized
      (begin
        (var-set manager tx-sender)
        (var-set goal target)
        (var-set deadline end)
        (var-set campaign-initialized true)
        (ok true))))

;; Contribute STX to the campaign
(define-public (contribute (amount uint))
  (let (
    (sender tx-sender)
    (current-block block-height)
  )
    (if (is-eq amount u0)
        err-zero-contribution
        (if (> current-block (var-get deadline))
            err-deadline-passed
            (match (stx-transfer? amount sender (as-contract tx-sender))
              ok-result
                (let ((existing (map-get? contributions { contributor: sender })))
                  (match existing entry
                    (begin
                      (map-set contributions { contributor: sender }
                        { amount: (+ (get amount entry) amount) })
                      (var-set total-raised (+ (var-get total-raised) amount))
                      (ok true))
                    (begin
                      (map-set contributions { contributor: sender }
                        { amount: amount })
                      (var-set total-raised (+ (var-get total-raised) amount))
                      (ok true))))
              err-result
                err-transfer-failed)))))

;; Withdraw funds if campaign goal is met
(define-public (withdraw)
  (if (is-eq tx-sender (var-get manager))
      (if (>= (var-get total-raised) (var-get goal))
          (stx-transfer? (var-get total-raised) (as-contract tx-sender) tx-sender)
          err-goal-not-met)
      err-unauthorized))

;; Refund contributors if goal not met after deadline
(define-public (claim-refund)
  (let (
    (sender tx-sender)
    (current-block block-height)
  )
    (if (<= current-block (var-get deadline))
        err-deadline-not-reached
        (if (>= (var-get total-raised) (var-get goal))
            err-goal-met
            (match (map-get? contributions { contributor: sender })
              entry
                (begin
                  (let ((amount (get amount entry)))
                    (begin
                      (map-delete contributions { contributor: sender })
                      (stx-transfer? amount (as-contract tx-sender) sender))))
              err-no-contribution)))))
