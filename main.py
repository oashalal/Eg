f = open("26.txt")

n = int(f.readline())

studs = []

for i  in range(n):
    s = f.readline()
    s = s.split()
    id = int(s[0])
    s = s[1:]
    sums = 0
    pls = 0
    count = 0

    for j in range(len(s)):
        nm = int(s[j])
        sums += nm
        if nm > 0:
            pls += nm
        if nm != 0:
            count+=1
        

    studs.append([-sums, -pls, -count, id])
    if i == 0:
        print([sums, pls, count, id])

studs = sorted(studs)
id = -1

last_winner = studs[3196]
print(last_winner)

for i in range(3196, n):
    it = studs[i]
    print(it)
    if (it[0] == last_winner[0]) and (it[1] == last_winner[1]) and (it[2] == last_winner[2]):
        continue
    id = it[3]
    break

us = studs[1499]
count = 0

for i in range(n):
    it = studs[i]
    if it[0] == us[0] and it[1] == us[1] and it[2] == us[2]:
        count += 1

print(id)
print(count)