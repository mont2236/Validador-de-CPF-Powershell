function Is-CpfValid {
    param (
        [string]$cpf
    )

    $multiplicador1 = @(10, 9, 8, 7, 6, 5, 4, 3, 2)
    $multiplicador2 = @(11, 10, 9, 8, 7, 6, 5, 4, 3, 2)
    $cpf = $cpf.Trim() -replace '\.', '' -replace '-', ''
    
    if ($cpf.Length -ne 11) {
        return $false
    }

    $tempCpf = $cpf.Substring(0, 9)
    $soma = 0

    for ($i = 0; $i -lt 9; $i++) {
        $soma += [int]$tempCpf[$i].ToString() * $multiplicador1[$i]
    }

    $resto = $soma % 11
    if ($resto -lt 2) {
        $resto = 0
    } else {
        $resto = 11 - $resto
    }

    $digito = $resto.ToString()
    $tempCpf += $digito
    $soma = 0

    for ($i = 0; $i -lt 10; $i++) {
        $soma += [int]$tempCpf[$i].ToString() * $multiplicador2[$i]
    }

    $resto = $soma % 11
    if ($resto -lt 2) {
        $resto = 0
    } else {
        $resto = 11 - $resto
    }

    $digito += $resto.ToString()
    return $cpf.EndsWith($digito)
}

# Exemplo de uso
$cpf = "12345678910"
if (Is-CpfValid -cpf $cpf) {
    Write-Output "CPF válido"
} else {
    Write-Output "CPF inválido"
}
