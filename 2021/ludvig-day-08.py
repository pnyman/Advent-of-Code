def det_output(cringelord, xd):
    corrs = ['']*10

    for i in cringelord:
        u = len(i)
        if u == 5 or u == 6:
            continue
        if u == 2:
            corrs[1] = i
        elif u == 4:
            corrs[4] = i
        elif u == 3:
            corrs[7] = i
        elif u == 7:
            corrs[8] = i

    for i in cringelord:
        if len(i) == 6:
            if set(corrs[4]).issubset(set(i)):
                corrs[9] = i
            elif set(corrs[1]).issubset(set(i)):
                corrs[0] = i
            else:
                corrs[6] = i

    e_seg = list(set(corrs[8]).difference(corrs[9]))
    for i in cringelord:
        if len(i) == 5:
            if set(corrs[1]).issubset(set(i)):
                corrs[3] = i
            elif set(e_seg).issubset(set(i)):
                corrs[2] = i
            else:
                corrs[5] = i

    output_result = ''
    for i in xd:
        for j in range(len(corrs)):
            if set(i) == set(corrs[j]):
                output_result += str(j)
    return int(output_result)
