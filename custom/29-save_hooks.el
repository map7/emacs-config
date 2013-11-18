(add-hook 'before-save-hook
          (lambda()
            (whitespace-cleanup)))
