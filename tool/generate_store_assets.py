"""
High-Fidelity Google Play Store Asset Generator:
- 1024x500 Feature Graphic
- 512x512 High-Res App Icon (with 4x supersampling for flawless vector antialiasing)
"""

import math
import os
import random
from PIL import Image, ImageDraw, ImageFilter, ImageFont, ImageOps

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
METADATA_DIR = os.path.join(BASE_DIR, 'metadata')
CARDS_DIR = os.path.join(BASE_DIR, 'assets', 'cards')

os.makedirs(METADATA_DIR, exist_ok=True)

# Colors
GOLD_BRIGHT = (255, 230, 140)
GOLD_PRIMARY = (218, 180, 60)
GOLD_DEEP = (160, 126, 30)
GOLD_PALE = (255, 248, 220)
TEXT_WHITE = (248, 250, 252)
TEXT_LIGHT = (210, 220, 235)

def get_font(font_name, size):
    paths = [
        f"C:/Windows/Fonts/{font_name}.ttf",
        f"C:/Windows/Fonts/{font_name.lower()}.ttf",
        f"C:/Windows/Fonts/{font_name.upper()}.TTF",
    ]
    for p in paths:
        if os.path.exists(p):
            try:
                return ImageFont.truetype(p, size)
            except Exception:
                pass
    return ImageFont.load_default()

def draw_gold_star(draw, cx, cy, r_outer, r_inner, fill):
    """Draws a 5-point star vector."""
    pts = []
    for i in range(10):
        r = r_outer if i % 2 == 0 else r_inner
        ang = i * (math.pi / 5) - math.pi / 2
        pts.append((cx + r * math.cos(ang), cy + r * math.sin(ang)))
    draw.polygon(pts, fill=fill)

def draw_diamond(draw, cx, cy, rx, ry, fill):
    """Draws a diamond vector."""
    pts = [
        (cx, cy - ry),
        (cx + rx, cy),
        (cx, cy + ry),
        (cx - rx, cy),
    ]
    draw.polygon(pts, fill=fill)

def generate_app_icon():
    """Generates 512x512 High-Res Icon via 4x supersampling (2048x2048)."""
    S = 2048
    scale = 4
    img = Image.new('RGBA', (S, S), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    cx, cy = S // 2, S // 2

    # Background Radial Gradient: deep cosmic midnight purple to void black
    max_r = int(S * 0.48)
    for r in range(max_r, 0, -2):
        ratio = r / max_r
        cr = int(24 * (1 - ratio) + 6 * ratio)
        cg = int(16 * (1 - ratio) + 4 * ratio)
        cb = int(44 * (1 - ratio) + 12 * ratio)
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(cr, cg, cb, 255))

    # Stardust in background
    rng = random.Random(137)
    for _ in range(140):
        sx = rng.randint(cx - max_r + 60, cx + max_r - 60)
        sy = rng.randint(cy - max_r + 60, cy + max_r - 60)
        if (sx - cx)**2 + (sy - cy)**2 < (max_r - 80)**2:
            sr = rng.randint(2, 6)
            alpha = rng.randint(120, 255)
            draw.ellipse([sx - sr, sy - sr, sx + sr, sy + sr], fill=(255, 240, 200, alpha))

    # Outer Concentric Alchemical Gold Rings
    ring_r = int(S * 0.45)
    for off in [0, 16, 44]:
        w = 10 if off == 16 else 4
        alpha = 255 if off == 16 else 140
        draw.ellipse([cx - ring_r + off, cy - ring_r + off, cx + ring_r - off, cy + ring_r - off],
                     outline=(GOLD_PRIMARY[0], GOLD_PRIMARY[1], GOLD_PRIMARY[2], alpha), width=w)

    # 16 Concentric Radiant Solar Rays
    for i in range(16):
        ang = i * (2 * math.pi / 16)
        r_in = ring_r - 44
        r_out = ring_r + (40 if i % 4 == 0 else 18)
        x1 = cx + r_in * math.cos(ang)
        y1 = cy + r_in * math.sin(ang)
        x2 = cx + r_out * math.cos(ang)
        y2 = cy + r_out * math.sin(ang)
        ray_w = 12 if i % 4 == 0 else 6
        draw.line([(x1, y1), (x2, y2)], fill=GOLD_BRIGHT, width=ray_w)

    # Inner Celestial Orbit Circle
    inner_orbit_r = int(S * 0.28)
    draw.ellipse([cx - inner_orbit_r, cy - inner_orbit_r, cx + inner_orbit_r, cy + inner_orbit_r],
                 outline=(GOLD_PRIMARY[0], GOLD_PRIMARY[1], GOLD_PRIMARY[2], 180), width=6)

    # Crescent Moon Crown
    moon_cy = cy - int(S * 0.24)
    moon_r = 130
    draw.pieslice([cx - moon_r, moon_cy - moon_r, cx + moon_r, moon_cy + moon_r], 200, 340, fill=GOLD_BRIGHT)
    # Mask out inner crescent
    draw.ellipse([cx - moon_r + 30, moon_cy - moon_r + 35, cx + moon_r + 30, moon_cy + moon_r - 10], fill=(16, 12, 30, 255))

    # The All-Seeing Eye of Providence:
    eye_half_w = int(S * 0.27)
    eye_half_h = int(S * 0.14)

    # Smooth parabolic eye shape
    eye_pts_top = []
    eye_pts_bottom = []
    steps = 40
    for i in range(steps + 1):
        t = (i / steps) * 2 - 1  # -1 to 1
        px = cx + t * eye_half_w
        # Parabolic height curve
        h_cur = eye_half_h * (1.0 - t * t)
        eye_pts_top.append((px, cy - h_cur))
        eye_pts_bottom.append((px, cy + h_cur))

    eye_poly = eye_pts_top + list(reversed(eye_pts_bottom))

    # Fill eye socket with deep void navy
    draw.polygon(eye_poly, fill=(16, 20, 34, 255))
    # Draw thick gold eye perimeter
    draw.line(eye_poly + [eye_poly[0]], fill=GOLD_BRIGHT, width=16)

    # Iris: Outer Gold Ring & Deep Indigo Core
    iris_r = int(S * 0.088)
    draw.ellipse([cx - iris_r, cy - iris_r, cx + iris_r, cy + iris_r],
                 fill=(24, 30, 50, 255), outline=GOLD_PRIMARY, width=14)

    # Inner Gold Pupil (Radiant 8-point Diamond)
    dw = int(S * 0.038)
    dh = int(S * 0.066)
    diamond_pts = [(cx, cy - dh), (cx + dw, cy), (cx, cy + dh), (cx - dw, cy)]
    draw.polygon(diamond_pts, fill=GOLD_PALE, outline=GOLD_BRIGHT)

    # Radiant Starlight Cross in Pupil
    cross_w = int(S * 0.016)
    cross_h = int(S * 0.032)
    draw.line([(cx, cy - cross_h), (cx, cy + cross_h)], fill=(255, 255, 255, 255), width=6)
    draw.line([(cx - cross_w, cy), (cx + cross_w, cy)], fill=(255, 255, 255, 255), width=6)

    # Core Sparkling Diamond Star
    draw.ellipse([cx - 14, cy - 14, cx + 14, cy + 14], fill=(255, 255, 255, 255))

    # Lower Altar Inverted Golden Triangle
    tri_pts = [
        (cx - 130, cy + int(S * 0.22)),
        (cx, cy + int(S * 0.14)),
        (cx + 130, cy + int(S * 0.22)),
    ]
    draw.polygon(tri_pts, outline=GOLD_PRIMARY, fill=(212, 175, 55, 40))

    # Resample to 512x512 with high quality Lanczos antialiasing
    final_icon = img.resize((512, 512), Image.Resampling.LANCZOS)
    out_path = os.path.join(METADATA_DIR, 'play_store_icon_512x512.png')
    final_icon.save(out_path, 'PNG', optimize=True)
    print(f"[OK] Generated Play Store Icon: {out_path} ({os.path.getsize(out_path)} bytes)")

def generate_feature_graphic():
    """Generates 1024x500 Feature Graphic with pristine custom vector accents."""
    w, h = 1024, 500
    img = Image.new('RGBA', (w, h), (10, 8, 18, 255))
    draw = ImageDraw.Draw(img)

    # Horizontal cosmic nebula gradient
    for x in range(w):
        dist = abs(x - 560) / 560
        ratio = max(0.0, 1.0 - dist)
        r = int(8 + 18 * ratio)
        g = int(6 + 10 * ratio)
        b = int(16 + 32 * ratio)
        draw.line([(x, 0), (x, h)], fill=(r, g, b, 255))

    # Background Stars
    rng = random.Random(77)
    for _ in range(150):
        sx = rng.randint(0, w)
        sy = rng.randint(0, h)
        sr = rng.choice([1, 1, 1, 2])
        alpha = rng.randint(90, 240)
        draw.ellipse([sx - sr, sy - sr, sx + sr, sy + sr], fill=(255, 245, 215, alpha))

    # Sacred Geometry Vector Circles in background
    bg_cx, bg_cy = 730, 250
    for r in [90, 150, 210, 270]:
        draw.ellipse([bg_cx - r, bg_cy - r, bg_cx + r, bg_cy + r],
                     outline=(GOLD_PRIMARY[0], GOLD_PRIMARY[1], GOLD_PRIMARY[2], 30), width=1)

    for i in range(12):
        ang = i * (2 * math.pi / 12)
        rx = bg_cx + 290 * math.cos(ang)
        ry = bg_cy + 290 * math.sin(ang)
        draw.line([(bg_cx, bg_cy), (rx, ry)], fill=(GOLD_PRIMARY[0], GOLD_PRIMARY[1], GOLD_PRIMARY[2], 25), width=1)

    # 3 Hero Tarot Cards fanned out on right
    card_files = [
        ('major_2_the_high_priestess.jpg', -13, (580, 235), 0.38),
        ('major_19_the_sun.jpg', 13, (880, 235), 0.38),
        ('major_17_the_star.jpg', 0, (730, 215), 0.44),  # Centered prominent hero card
    ]

    for fname, rot_angle, (pos_x, pos_y), scale in card_files:
        cpath = os.path.join(CARDS_DIR, fname)
        if not os.path.exists(cpath):
            continue

        card_img = Image.open(cpath).convert('RGBA')
        orig_w, orig_h = card_img.size
        new_w = int(orig_w * scale)
        new_h = int(orig_h * scale)
        card_img = card_img.resize((new_w, new_h), Image.Resampling.LANCZOS)

        # 24k Gold Frame around card
        card_bordered = ImageOps.expand(card_img, border=4, fill=GOLD_PRIMARY)

        # Rotate card
        if rot_angle != 0:
            rotated = card_bordered.rotate(rot_angle, expand=True, resample=Image.Resampling.BICUBIC)
        else:
            rotated = card_bordered

        # Drop Shadow
        shadow = Image.new('RGBA', rotated.size, (0, 0, 0, 0))
        shadow_draw = ImageDraw.Draw(shadow)
        shadow_draw.bitmap((0, 0), rotated.split()[-1], fill=(0, 0, 0, 175))
        shadow = shadow.filter(ImageFilter.GaussianBlur(14))

        paste_x = pos_x - rotated.width // 2
        paste_y = pos_y - rotated.height // 2
        img.paste(shadow, (paste_x + 8, paste_y + 12), shadow)
        img.paste(rotated, (paste_x, paste_y), rotated)

    # Fonts
    font_title = get_font('georgiab', 56)
    font_sub = get_font('georgiab', 17)
    font_badge = get_font('georgia', 13)
    font_body = get_font('cambria', 15)

    left_x = 72

    # Category Eyebrow with flanking gold diamonds
    draw_diamond(draw, left_x + 6, 98, 4, 6, GOLD_BRIGHT)
    draw.text((left_x + 18, 91), "SACRED DIVINATION ALTAR", fill=GOLD_BRIGHT, font=font_badge)
    draw_diamond(draw, left_x + 228, 98, 4, 6, GOLD_BRIGHT)

    # Title: ORACULUM
    draw.text((left_x + 2, 122), "ORACULUM", fill=(0, 0, 0, 200), font=font_title)
    draw.text((left_x, 120), "ORACULUM", fill=GOLD_BRIGHT, font=font_title)

    # Subtitle
    draw.text((left_x, 192), "SACRED AI TAROT & ASTROLOGY", fill=(226, 232, 240, 245), font=font_sub)

    # Gold Divider with Center Diamond
    draw.line([(left_x, 224), (left_x + 360, 224)], fill=GOLD_PRIMARY, width=2)
    draw_diamond(draw, left_x + 180, 224, 5, 5, GOLD_BRIGHT)

    # Feature Bullets with glowing gold diamond icons
    bullets = [
        "78-Card Whispers & Warnings Luxury Gothic Deck",
        "Real-Time 3D Holographic Gold Foil Perspective",
        "Full Natal Ephemeris Chart & Moon Phase Tracking",
        "Archetypal Pathworkings & Solfeggio Resonator",
    ]
    cur_y = 248
    for bullet in bullets:
        draw_diamond(draw, left_x + 5, cur_y + 9, 3, 5, GOLD_BRIGHT)
        draw.text((left_x + 18, cur_y), bullet, fill=TEXT_LIGHT, font=font_body)
        cur_y += 28

    # Quality Badge with Star Vector
    badge_rect = [left_x, 386, left_x + 360, 428]
    draw.rounded_rectangle(badge_rect, radius=12, fill=(24, 18, 44, 210), outline=GOLD_PRIMARY, width=1)
    draw_gold_star(draw, left_x + 24, 407, 7, 3, GOLD_BRIGHT)
    draw.text((left_x + 36, 399), "4.9 RATING · POWERED BY GOOGLE GEMINI AI", fill=GOLD_BRIGHT, font=font_badge)

    out_path = os.path.join(METADATA_DIR, 'play_store_feature_graphic_1024x500.png')
    img.save(out_path, 'PNG', optimize=True)
    print(f"[OK] Generated Play Store Feature Graphic: {out_path} ({os.path.getsize(out_path)} bytes)")

if __name__ == '__main__':
    generate_app_icon()
    generate_feature_graphic()
