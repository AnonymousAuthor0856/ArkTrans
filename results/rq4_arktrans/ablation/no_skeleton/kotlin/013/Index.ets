// === Stack ===
// props: { alignContent: Alignment.Top }
// children: 2
Stack() {
  // === Column ===
  // props: { space: 16, verticalAlignment: VerticalAlign.SpaceBetween }
  // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#FFFCF2' }
  // children: 4
  Column() {
    // === Text ===
    // props: { text: 'Retro Music Player' }
    // modifier: { fontSize: 30, fontWeight: FontWeight.Bold, color: '#1F1F1F', textAlign: TextAlign.Center }
    Text() {}

    // === Box (Canvas) ===
    // modifier: { width: 280, height: 280, backgroundColor: '#FFF8E1', borderRadius: 16, borderColor: '#BDBDBD', borderWidth: 3 }
    // children: 1
    Box() {
      // === Canvas ===
      // props: { size: { width: 280, height: 280 }, draw: (ctx) => { ... } }
      Canvas() {}
    }

    // === Text ===
    // props: { text: 'Track: Summer Nights' }
    // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1F1F1F', textAlign: TextAlign.Center }
    Text() {}

    // === Row ===
    // props: { space: 16, horizontalAlignment: HorizontalAlign.SpaceEvenly }
    // modifier: { width: '100%' }
    // children: 2
    Row() {
      // === Button ===
      // props: { onClick: () => {} }
      // modifier: { width: 120, height: 48, backgroundColor: '#EF476F', borderRadius: 12 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Play' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#FFF' }
        Text() {}
      }
      // === Button ===
      // props: { onClick: () => {} }
      // modifier: { width: 120, height: 48, backgroundColor: '#FFD166', borderRadius: 12 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Pause' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1F1F1F' }
        Text() {}
      }
    }

    // === Text ===
    // props: { text: 'Knob X:300 Y:300' }
    // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#06D6A0', textAlign: TextAlign.Center }
    Text() {}
  }

  // === Blank ===
  Blank() {}
}
// modifier: { width: '100%', height: '100%' }