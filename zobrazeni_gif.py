import matplotlib.pyplot as plt
import imageio
import io

x_coords, y_coords = [], []
with open("dla_data2.txt", "r") as file:
    for line in file:
        x, y = map(int, line.split())
        x_coords.append(x)
        y_coords.append(y)

images = []     # Создание анимации

step_size = 5   # Добавляем 5 точек за каждый шаг анимации
num_points = len(x_coords)

for i in range(0, num_points, step_size):
    plt.figure(figsize=(6, 6))
    plt.scatter(x_coords[:i], y_coords[:i], color='black')
    plt.title(f"Частиц: {i}")
    plt.axis('square')

    # Сохраняем изображение в буфер вместо файла
    buf = io.BytesIO()
    plt.savefig(buf, format='png')
    buf.seek(0)
    image = imageio.imread(buf)
    images.append(image)
    buf.close()
    plt.close()


imageio.mimsave('snowflake_growth.gif', images, fps=10)  # Можно настроить скорость анимации через fps # Создание гифки





# for i in range(1, len(x_coords) + 1, 2):  # каждую 10-ю точку
#     plt.figure(figsize=(6, 6))
#     plt.scatter(x_coords[:i], y_coords[:i], color='black')
#     # plt.title(f"Шаг {i}")
#     plt.axis('square')
    
#     buf = io.BytesIO()    
#     plt.savefig(buf, format='png')
#     buf.seek(0)
#     image = imageio.imread(buf)
#     images.append(image)
#     buf.close()
#     plt.close()


# imageio.mimsave('snowflake_growth.gif', images, fps=10)  
