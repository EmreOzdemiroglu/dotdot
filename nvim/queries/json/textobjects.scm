; extends

; "key": value çifti -> aa (tamamı), ia (sadece değer)
(pair value: (_) @parameter.inner) @parameter.outer

; Dizi elemanı -> aa / ia
(array (_) @parameter.inner @parameter.outer)
