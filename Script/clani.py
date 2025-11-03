import sqlite3
import os
from pathlib import Path

def get_teams_from_db(db_path='adum_baza.db'):
    try:
        conn = sqlite3.connect(db_path)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        query = """
        SELECT 
            role_id,
            role_name,
            created_at
        FROM role_team
        ORDER BY role_id
        """

        cursor.execute(query)
        teams = cursor.fetchall()
        conn.close()
        return teams
    except Exception as e:
        print(f"Error reading teams: {e}")
        return []

def get_members_from_db(db_path='adum_baza.db'):
    try:
        conn = sqlite3.connect(db_path)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        query = """ 
        SELECT 
        members.member_id,
        members.name,
        members.lastname,
        members.sort_order,
        members.active,
        role_team.role_name,
        images.src as image_src
        FROM members
        LEFT JOIN role_team ON members.role_id = role_team.role_id
        LEFT JOIN images ON members.image_id = images.image_id
        WHERE members.active = 1
        ORDER BY members.sort_order, members.name
        """

        cursor.execute(query)
        members = cursor.fetchall()
        conn.close()
        return members
    except Exception as e:
        print(f"Error reading members: {e}")
        return []

def generate_role_title(role_name):
    if not role_name:
        return "Člani"
    
    clean_name = role_name.replace('_',' ').title()
    clean_name += " Tim"
    
    return clean_name

def generate_members_html(members, teams):
    roles_dict = {}
    for member in members:
        role = member['role_name'] if member['role_name'] else 'Člani'
        role_title = generate_role_title(role)
        
        if role_title not in roles_dict:
            roles_dict[role_title] = []
        roles_dict[role_title].append(member)
    
    html_content = f"""<!DOCTYPE html>
<html lang="sl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADUM - Člani</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-container">
                <div class="logo">
                    <h2>ADUM</h2>
                </div>
                <ul class="nav-menu">
                    <li><a href="index.html">Domov</a></li>
                    <li><a href="novice.html">Novice</a></li>
                    <li><a href="prosla_tekmovanja.html">Prošla Tekmovanja</a></li>
                    <li><a href="clani.html" class="active">Člani</a></li>
                    <li><a href="galerija.html">Galerija</a></li>
                    <li><a href="kontakt.html">Kontakt</a></li>
                </ul>
                <div class="hamburger">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </nav>
    </header>

    <main class="members-section">
        <div class="container">
            <h1 class="members-title">Naša Ekipa</h1>
            <p class="members-subtitle">Spoznajte našo ekipo strokovnjakov, posvečenih inovacijam, odličnosti in timskemu delu na področju tehnologije in inženiringa.</p>
"""
    
    # Add members grouped by roles
    for role_title, role_members in sorted(roles_dict.items()):
        if not role_members:
            continue
            
        html_content += f"""
            <div class="role-section">
                <div class="role-header">
                    <h2 class="role-title">{role_title}</h2>
                </div>
                <div class="members-grid">
"""
        
        for member in role_members:
            full_name = f"{member['name']} {member['lastname']}" if member['lastname'] else member['name']
            
            # Check if image exists and fix path
            if member['image_src']:
                image_path = member['image_src'].replace('../Site/', '')
                image_html = f'<img src="{image_path}" alt="{full_name}" class="member-image">'
            else:
                image_html = '<div class="no-image"></div>'
            
            html_content += f"""
                <div class="member-card">
                    <div class="member-image-container">
                        {image_html}
                    </div>
                    <div class="member-info">
                        <h3 class="member-name">{full_name}</h3>
                    </div>
                </div>
"""
        
        html_content += """
                </div>
            </div>
"""
    
    html_content += """
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 ADUM. Vse pravice pridržane.</p>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>"""
    
    return html_content

def main():
    """Main function"""
    db_path = 'adum_baza.db'
    output_path = '../Site/clani.html'
    
    current_dir = os.getcwd()
    print(f"Current directory: {current_dir}")
    print(f"Looking for database: {db_path}")
    
    if os.path.exists(db_path):
        print(f"Database found: {os.path.abspath(db_path)}")
    else:
        print(f"Database NOT found at: {os.path.abspath(db_path)}")
        print("Files in current directory:")
        for file in os.listdir('.'):
            print(f"  - {file}")
        return
    
    try:
        teams = get_teams_from_db(db_path)
        members = get_members_from_db(db_path)
        
        if not teams:
            print("No teams found in database!")
            return
        
        print(f"Found {len(teams)} teams:")
        for team in teams:
            display_name = generate_role_title(team['role_name'])
            print(f"- {team['role_name']} → '{display_name}'")
        
        if members:
            print(f"Found {len(members)} active members")
            for member in members:
                print(f"- {member['name']} {member['lastname']} ({member['role_name']})")
        else:
            print("No active members in database!")
        
        html_content = generate_members_html(members, teams)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        print(f"Members page successfully generated: {output_path}")
        
        if os.path.exists(output_path):
            print(f"File successfully created: {os.path.abspath(output_path)}")
        else:
            print(f"File was not created: {output_path}")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()