from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import os
import time
import subprocess


demo_ids = [ str(i) for i in range(103400, 104600)]

base_dir = "/home/pierrer/PipelineCS/DL"

options = Options()
options.add_argument("--headless")
options.add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
options.add_experimental_option("prefs", {
    "download.prompt_for_download": False,
})

for demo_id in demo_ids:
    demo_dir = os.path.join(base_dir, demo_id)
    if not os.path.isdir(demo_dir) :
        os.makedirs(demo_dir, exist_ok=True)

        options.add_experimental_option("prefs", {
            "download.default_directory": demo_dir,
        })

        driver = webdriver.Chrome(options=options)

        download_url = f"https://www.hltv.org/download/demo/{demo_id}"
        driver.get(download_url)

        rar_file = None
        for _ in range(60):
            files = os.listdir(demo_dir)
            rar_files = [f for f in files if f.endswith(".rar")]
            if rar_files:
                rar_file = os.path.join(demo_dir, rar_files[0])
                break
            time.sleep(1)

        if not rar_file:
            print(f"Erreur : téléchargement de {demo_id} non détecté.")
            driver.quit()
            continue

        previous_size = -1
        for _ in range(30):
            current_size = os.path.getsize(rar_file)
            if current_size == previous_size and current_size > 0:
                break
            previous_size = current_size
            time.sleep(1)

        driver.quit()

        try:
            subprocess.run(["unrar", "e", rar_file, demo_dir], check=True)
            print(f"Extraction terminée pour {demo_id}.")
        except subprocess.CalledProcessError as e:
            print(f"Erreur lors de l'extraction de {rar_file} : {e}")
            continue
        


        os.remove(rar_file)
        print(f"Téléchargement et extraction terminés pour {demo_id}.")

        for file in os.listdir(demo_dir):
            subprocess.run(["../squashfs-root/csdm","analyze","--analyze-positions", demo_dir + "/" + file, "--source", "valve"])
            subprocess.run(["rm", demo_dir + "/" + file])

print("Tous les téléchargements sont terminés.")
