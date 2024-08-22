# Server Monitoring Menggunakan Grafana dan Uptime Kuma 

Dokumentasi berikut menunjukkan bagaimana cara instalasi Grafana dan Uptime Kuma menggunakan Docker Compose

## Prasyarat

- [Git](https://git-scm.com/downloads)
- [Docker](https://docs.docker.com/get-docker/)

## Instalasi

1. Clone project berikut pada Monitoring Server dan Monitored Server

    ```bash
    git clone https://git.tlab.co.id/akmal/server-monitoring.git
    ```

2. Menjalankan Uptime Kuma terlebih dahulu

    ```bash
    docker compose up -d uptime-kuma
    ```

3. Akses dashboard Uptime Kuma ($IP_ADDRESS:3001) dan buat username serta passwordnya

4. Selanjutnya jalankan Node Exporter pada Monitored Host yang diinginkan. Terdapat dua opsi untuk menjalankan Node Exporter:

    - Menggunakan Docker:

        Jalankan file node-exporter.sh dan masukkan port yang ingin digunakan

        ```bash
        ./node-exporter.sh
        ```

    - Menggunakan Docker Compose:

        Sesuaikan dulu port yang digunakan pada file compose-note-exporter.yml sesuai dengan yang ingin digunakan, kemudian jalankan:

        ```bash
        docker compose -f compose-node-exporter.yml up -d
        ```

5. Terdapat beberapa konfigurasi yang perlu kita sesuaikan pada file server-monitoring/prometheus/prometheus.yml:

    - Alamat IP dan Port Monitored Host

        Masukkan Alamat IP dan Port yang digunakan pada saat memasang Node Exporter di Monitored Host

    - Basic Authentication Uptime Kuma

        Menggunakan username dan password yang dimasukkan sesuai di langkah nomor 3

6. Selain itu kita juga perlu melakukan konfigurasi untuk mengaktifkan notifikasi ke gmail menggunakan Grafana. Untuk notifikasi membutuhkan App Password yang panduan pembuatannya dapat diikuti di [link berikut](https://support.google.com/mail/answer/185833?hl=en). Buka file server-monitoring/grafana/grafana.ini dan sesuaikan bagian berikut

    ```
    [smtp]
    enabled = true
    host = smtp.gmail.com:587
    user = masukkan alamat email pengirim
    password = masukkan app password
    from_address = masukkan alamat email pengirim
    from_name = Grafana
    ```

7. Jalankan keseluruhan service menggunakan docker-compose.yml

    ```bash
    docker compose up -d
    ```

8. Dengan ini Grafana, Prometheus, dan Uptime Kuma telah berjalan dan dapat diakses di alamat berikut:

    - $IP_ADDRESS:3000 - Grafana
    - $IP_ADDRESS:9090 - Prometheus
    - $IP_ADDRESS:3001 - Uptime Kuma

9. Untuk memudahkan proses pembuatan dashboard di Grafana, kita bisa menggunakan contoh dashboard yang telah tersedia di website [Grafana](https://grafana.com/grafana/dashboards/)
