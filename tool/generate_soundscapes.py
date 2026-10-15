import math
import struct
import wave
import os

SAMPLE_RATE = 44100
DURATION = 10.0  # Exactly 10 seconds yields integer cycle counts for all Solfeggio harmonics
TOTAL_SAMPLES = int(SAMPLE_RATE * DURATION)
OUTPUT_DIR = os.path.join(os.path.dirname(__file__), '..', 'assets', 'audio')

def write_wav(filename: str, samples_left: list[float], samples_right: list[float]):
    filepath = os.path.join(OUTPUT_DIR, filename)
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    
    with wave.open(filepath, 'w') as wav:
        wav.setnchannels(2)      # Stereo
        wav.setsampwidth(2)      # 16-bit
        wav.setframerate(SAMPLE_RATE)
        
        frames = bytearray()
        for l, r in zip(samples_left, samples_right):
            # Clamp between -1.0 and 1.0 with subtle soft knee
            cl = max(-0.95, min(0.95, l))
            cr = max(-0.95, min(0.95, r))
            # Convert to signed 16-bit integer (-32768 to 32767)
            il = int(cl * 32767.0)
            ir = int(cr * 32767.0)
            frames.extend(struct.pack('<hh', il, ir))
            
        wav.writeframes(frames)
    print(f"Generated {filename} ({os.path.getsize(filepath):,} bytes)")

def generate_432_hz():
    # 432 Hz Solfeggio Cosmic Grounding + 4 Hz Theta binaural beat
    left, right = [], []
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        # Gentle breathing envelope (10s cycle)
        breath = 0.85 + 0.15 * math.sin(2.0 * math.pi * 0.1 * t)
        
        # Left channel: 432Hz fundamental + 216Hz sub-octave + 864Hz shimmer
        sl = (0.50 * math.sin(2.0 * math.pi * 432.0 * t) +
              0.30 * math.sin(2.0 * math.pi * 216.0 * t) +
              0.15 * math.sin(2.0 * math.pi * 864.0 * t)) * breath
        
        # Right channel: 436Hz (+4Hz Theta beat) + 216Hz + 872Hz
        sr = (0.50 * math.sin(2.0 * math.pi * 436.0 * t) +
              0.30 * math.sin(2.0 * math.pi * 216.0 * t) +
              0.15 * math.sin(2.0 * math.pi * 872.0 * t)) * breath
        
        left.append(sl * 0.75)
        right.append(sr * 0.75)
    write_wav('solfeggio_432.wav', left, right)

def generate_528_hz():
    # 528 Hz Solfeggio Transformation & Heart + 4.5 Hz Theta binaural beat
    left, right = [], []
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        # Harmonic pulse
        pulse = 0.88 + 0.12 * math.cos(2.0 * math.pi * 0.2 * t)
        
        # Left: 528 Hz + 264 Hz octave + 1056 Hz crystal harmonic
        sl = (0.55 * math.sin(2.0 * math.pi * 528.0 * t) +
              0.28 * math.sin(2.0 * math.pi * 264.0 * t) +
              0.12 * math.sin(2.0 * math.pi * 1056.0 * t)) * pulse
              
        # Right: 532.5 Hz (+4.5 Hz Theta beat) + 264 Hz + 1065 Hz
        sr = (0.55 * math.sin(2.0 * math.pi * 532.5 * t) +
              0.28 * math.sin(2.0 * math.pi * 264.0 * t) +
              0.12 * math.sin(2.0 * math.pi * 1065.0 * t)) * pulse
              
        left.append(sl * 0.75)
        right.append(sr * 0.75)
    write_wav('solfeggio_528.wav', left, right)

def generate_741_hz():
    # 741 Hz Solfeggio Intuition & Psychic Clarity + 6 Hz Alpha-Theta beat
    left, right = [], []
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        shimmer = 0.90 + 0.10 * math.sin(2.0 * math.pi * 0.3 * t)
        
        # Left: 741 Hz + 370.5 Hz deep anchor + 1482 Hz celestial overtone
        sl = (0.52 * math.sin(2.0 * math.pi * 741.0 * t) +
              0.32 * math.sin(2.0 * math.pi * 370.5 * t) +
              0.10 * math.sin(2.0 * math.pi * 1482.0 * t)) * shimmer
              
        # Right: 747 Hz (+6 Hz beat) + 370.5 Hz + 1494 Hz
        sr = (0.52 * math.sin(2.0 * math.pi * 747.0 * t) +
              0.32 * math.sin(2.0 * math.pi * 370.5 * t) +
              0.10 * math.sin(2.0 * math.pi * 1494.0 * t)) * shimmer
              
        left.append(sl * 0.72)
        right.append(sr * 0.72)
    write_wav('solfeggio_741.wav', left, right)

def generate_celestial_drone():
    # Deep 108 Hz Om drone with sacred fifths and octaves (108, 162, 216, 324, 432 Hz)
    left, right = [], []
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        pan_mod_l = 0.5 + 0.2 * math.sin(2.0 * math.pi * 0.1 * t)
        pan_mod_r = 0.5 + 0.2 * math.cos(2.0 * math.pi * 0.1 * t)
        
        # Deep resonant cosmic chord
        f108 = math.sin(2.0 * math.pi * 108.0 * t)
        f162 = math.sin(2.0 * math.pi * 162.0 * t)
        f216 = math.sin(2.0 * math.pi * 216.0 * t)
        f324 = math.sin(2.0 * math.pi * 324.0 * t)
        f432 = math.sin(2.0 * math.pi * 432.0 * t)
        
        sl = (0.35 * f108 + 0.25 * f162 + 0.20 * f216 + 0.12 * f324 + 0.08 * f432) * pan_mod_l
        sr = (0.35 * f108 + 0.25 * f162 + 0.20 * f216 + 0.12 * f324 + 0.08 * f432) * pan_mod_r
        
        left.append(sl * 0.85)
        right.append(sr * 0.85)
    write_wav('celestial_drone.wav', left, right)

def generate_tibetan_bowls():
    # Tibetan Singing Bowls & Sacred Chimes (288 Hz + 576 Hz + 864 Hz + 1440 Hz)
    left, right = [], []
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        # Singing bowl rim vibration modulation (slow rotating chorus)
        rot_l = 0.8 + 0.2 * math.sin(2.0 * math.pi * 0.2 * t)
        rot_r = 0.8 + 0.2 * math.cos(2.0 * math.pi * 0.2 * t)
        
        # Harmonics
        b1 = math.sin(2.0 * math.pi * 288.0 * t)
        b2 = math.sin(2.0 * math.pi * 576.0 * t)
        b3 = math.sin(2.0 * math.pi * 864.0 * t)
        b4 = math.sin(2.0 * math.pi * 1440.0 * t)
        
        sl = (0.42 * b1 + 0.30 * b2 + 0.18 * b3 + 0.10 * b4) * rot_l
        sr = (0.42 * b1 + 0.30 * b2 + 0.18 * b3 + 0.10 * b4) * rot_r
        
        left.append(sl * 0.80)
        right.append(sr * 0.80)
    write_wav('tibetan_bowls.wav', left, right)

def generate_astral_breeze():
    # Ethereal cosmic astral wind swells (harmonic resonant wind sweeps)
    left, right = [], []
    # Seeded pseudorandom multi-frequency wind harmonics
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        # Deep breathing wind swells (0.1 Hz = 10s period)
        swell_l = 0.6 + 0.4 * math.sin(2.0 * math.pi * 0.1 * t)
        swell_r = 0.6 + 0.4 * math.sin(2.0 * math.pi * 0.1 * t + 0.5)
        
        # Wind harmonics (gentle hollow flute-like whispering frequencies)
        w1 = math.sin(2.0 * math.pi * 144.0 * t)
        w2 = math.sin(2.0 * math.pi * 216.0 * t + 0.3)
        w3 = math.sin(2.0 * math.pi * 360.0 * t + 0.6)
        w4 = math.sin(2.0 * math.pi * 504.0 * t + 0.9)
        w5 = math.sin(2.0 * math.pi * 720.0 * t + 1.2)
        
        sl = (0.35 * w1 + 0.25 * w2 + 0.20 * w3 + 0.12 * w4 + 0.08 * w5) * swell_l
        sr = (0.35 * w1 + 0.25 * w2 + 0.20 * w3 + 0.12 * w4 + 0.08 * w5) * swell_r
        
        left.append(sl * 0.70)
        right.append(sr * 0.70)
    write_wav('astral_breeze.wav', left, right)

if __name__ == '__main__':
    print("Beginning generation of sacred Solfeggio soundscapes...")
    generate_432_hz()
    generate_528_hz()
    generate_741_hz()
    generate_celestial_drone()
    generate_tibetan_bowls()
    generate_astral_breeze()
    print("All 6 sacred soundscape audio files generated successfully!")
