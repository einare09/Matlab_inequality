if abs(sum(Firms.TotalInterestPayments)+sum(CstrFirms.TotalInterestPayments)-sum(Banks.TotalInterestProceeds))>1e-6
    error('Error in the interest payments flow consistency check')
end