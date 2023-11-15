import matplotlib.pyplot as plt

x = []
y = []

with open("dla_data2.txt", "r") as file:
    for radek in file:
        xi, yi = map(int, radek.split())
        x.append(xi)
        y.append(yi)

plt.scatter(x, y, color='black')
plt.axis('square')
plt.show()
plt.savefig("dla_data4.png")