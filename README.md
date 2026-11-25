
PC BUILDER

**Team:** Z8 · Artificial Intelligence lab, Collegium Da Vinci, 2026/2027 · group L2


## What it does

PC Builder is an expert system designed for users who want to configure a custom desktop computer without spending hours manually checking hardware compatibility. The user inputs their target budget (in PLN), intended use case (Gaming, Workstation, or Office), and optional CPU/GPU brand preferences. Based on these parameters, the system outputs a complete, technically compatible PC parts list within budget, complete with reasoning logs and a downloadable `.txt` specification summary.

## AI technique

The project uses rule-based forward chaining grounded in propositional and first-order logic to deduce system requirements (such as PSU wattage margins and anti-bottleneck constraints) and prune incompatible components directly in SQL. Unlike rigid `if-else` trees that become unmaintainable or neural networks that could hallucinate incompatible hardware pairings, rule-based reasoning guarantees 100% component compatibility and strict budget compliance.

## Results

Across 8 tested budget scenarios (5,000–10,000 PLN), our system outperformed pre-built retail PCs (Komputronik, x-kom, OleOle!, dell24.pl) in 6 out of 8 cases—offering higher gaming performance, superior GPU tiers (up to RTX 5070 Ti / RX 9070 XT instead of RTX 5060), and greater VRAM capacity—while achieving a performance tie in 2 office configurations. Algorithmically, the engine resolves configurations in under 1 second using 10–11 rules instead of evaluating the full Cartesian product of the database tables.

## How to run

```
git clone [https://github.com/twdoppe/si-l2-z8-PCBuilder](https://github.com/twdoppe/si-l2-z8-PCBuilder)
cd si-l2-z8-PCBuilder/pcbuilder
pip install flask pymysql
python app.py

```

Requirements:

 1. Python 3.11+ and XAMPP with the MySQL module running on 127.0.0.1:3306 (user root, empty password).

 2. Create a MySQL database named pckonfig via phpMyAdmin (http://localhost/phpmyadmin) and import the 7 SQL dataset tables (procesory, karty_graficzne, plyty_glowne, pamiec_ram, dyski, pc_cases, power_supplies).

 3. Once python app.py is running, open http://127.0.0.1:5000/ in your browser; the recommended PC build and reasoning logs appear directly on the page after submitting the form.

## Team

 1. Mykola Haponov – datasets, user interface, presentation

 2. Artem Chornyi – user interface, documentation, presentation

 3. Danyl Pavlenko – core reasoning engine and datasets
 
## Documentation

Full documentation in Polish: `docs/dokumentacja.md`, in English: `docs/dokumentacja_ang.md` .
