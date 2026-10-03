@Entry
@Component
struct HabitTrackerScreen {
  @State v: number = 50

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Color ===
      // modifier: { width: '100%', height: '100%' }
      Color('#FFFFFF')
        .width('100%')
        .height('100%')

      // === Scroll ===
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: 24 }
        // children: 13
        Column({ space: 0 }) {
          // === Blank ===
          // modifier: { height: 24 }
          Blank().height(24)

          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%' }
          // children: 3
          Row({ space: 0 }) {
            // === Column ===
            // props: { space: 0 }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'THURSDAY' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, letterSpacing: 1, color: '#757575' }
              Text('THURSDAY').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1).fontColor('#757575')
              // === Text ===
              // props: { text: 'Dec 04' }
              // modifier: { fontSize: 24, fontWeight: FontWeight.Black, color: '#121212' }
              Text('Dec 04').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#121212')
            }

            // === Blank ===
            Blank()

            // === Button ===
            // modifier: { width: 40, height: 40, border: { width: 1, color: '#F5F5F5', radius: 20 }, margin: { right: -8 } }
            // children: 1
            Button() {
              // === Image ===
              // modifier: { width: 24, height: 24, color: '#121212' }
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#121212')
            }.width(40).height(40).border({ width: 1, color: '#F5F5F5', radius: 20 }).margin({ right: -8 })
          }.width('100%')

          // === Blank ===
          // modifier: { height: 32 }
          Blank().height(32)

          // === Component: StatsCard ===
          // (Inline implementation based on SwiftUI struct)
          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%', height: 140, backgroundColor: '#121212', borderRadius: 24, padding: 24 }
          // children: 1
          Row({ space: 0 }) {
            // === Column ===
            // props: { space: 0 }
            // modifier: { layoutWeight: 1 }
            // children: 4
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Overall Progress' }
              // modifier: { fontSize: 14, color: '#B3FFFFFF' }
              Text('Overall Progress').fontSize(14).fontColor('#B3FFFFFF')
              // === Blank ===
              // modifier: { height: 8 }
              Blank().height(8)
              // === Text ===
              // props: { text: '85%' }
              // modifier: { fontSize: 48, fontWeight: FontWeight.Bold, color: '#FFF' }
              Text('85%').fontSize(48).fontWeight(FontWeight.Bold).fontColor('#FFF')
              // === Blank ===
              // modifier: { height: 4 }
              Blank().height(4)
              // === Row ===
              // props: { space: 0 }
              // children: 2
              Row({ space: 0 }) {
                // === Image ===
                // modifier: { width: 16, height: 16, color: '#FFD700' }
                Image($r('app.media.startIcon')).width(16).height(16).fillColor('#FFD700')
                // === Blank ===
                // modifier: { width: 4 }
                Blank().width(4)
                // === Text ===
                // props: { text: '12 Day Streak!' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#FFF' }
                Text('12 Day Streak!').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }
            }.layoutWeight(1)
          }.width('100%').height(140).backgroundColor('#121212').borderRadius(24).padding(24)

          // === Blank ===
          // modifier: { height: 32 }
          Blank().height(32)

          // === Text ===
          // props: { text: "TODAY'S GOALS" }
          // modifier: { width: '100%', fontSize: 12, fontWeight: FontWeight.Bold, letterSpacing: 1.5, color: '#757575' }
          Text("TODAY'S GOALS").width('100%').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1.5).fontColor('#757575')

          // === Blank ===
          // modifier: { height: 16 }
          Blank().height(16)

          // === Component: HabitItem (Morning Meditation) ===
          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, border: { width: 1, color: '#F5F5F5', radius: 16 }, marginBottom: 8 }
          // children: 4
          Row({ space: 0 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 48, height: 48 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 48, height: 48, fill: '#F5F5F5' }
              Circle().width(48).height(48).fill('#F5F5F5')
              // === Image ===
              // modifier: { width: 24, height: 24, color: '#121212' }
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#121212')
            }

            // === Blank ===
            // modifier: { width: 16 }
            Blank().width(16)

            // === Column ===
            // props: { space: 0 }
            // modifier: { layoutWeight: 1 }
            // children: 3
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Morning Meditation' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#757575', textDecoration: TextDecoration.LineThrough }
              Text('Morning Meditation').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#757575').decoration({ type: TextDecorationType.LineThrough })
              // === Blank ===
              // modifier: { height: 2 }
              Blank().height(2)
              // === Text ===
              // props: { text: '15 minutes mindfulness' }
              // modifier: { fontSize: 12, color: '#757575' }
              Text('15 minutes mindfulness').fontSize(12).fontColor('#757575')
            }.layoutWeight(1)

            // === Blank ===
            // modifier: { width: 8 }
            Blank().width(8)

            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 32, height: 32 }
            // children: 3
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 32, height: 32, fill: '#4CAF50' }
              Circle().width(32).height(32).fill('#4CAF50')
              // === Circle ===
              // modifier: { width: 32, height: 32, stroke: { width: 2, color: '#4CAF50' } }
              Circle().width(32).height(32).strokeWidth(2).stroke('#4CAF50')
              // === Image ===
              // modifier: { width: 18, height: 18, color: '#FFF' }
              Image($r('app.media.startIcon')).width(18).height(18).fillColor('#FFF')
            }
          }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).border({ width: 1, color: '#F5F5F5', radius: 16 }).margin({ bottom: 8 })

          // === Component: HabitItem (Gym Session) ===
          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, border: { width: 1, color: '#F5F5F5', radius: 16 }, marginBottom: 8 }
          // children: 4
          Row({ space: 0 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 48, height: 48 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 48, height: 48, fill: '#F5F5F5' }
              Circle().width(48).height(48).fill('#F5F5F5')
              // === Image ===
              // modifier: { width: 24, height: 24, color: '#121212' }
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#121212')
            }

            // === Blank ===
            // modifier: { width: 16 }
            Blank().width(16)

            // === Column ===
            // props: { space: 0 }
            // modifier: { layoutWeight: 1 }
            // children: 3
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Gym Session' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#121212' }
              Text('Gym Session').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#121212')
              // === Blank ===
              // modifier: { height: 2 }
              Blank().height(2)
              // === Text ===
              // props: { text: 'Upper body workout' }
              // modifier: { fontSize: 12, color: '#757575' }
              Text('Upper body workout').fontSize(12).fontColor('#757575')
            }.layoutWeight(1)

            // === Blank ===
            // modifier: { width: 8 }
            Blank().width(8)

            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 32, height: 32 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 32, height: 32, fill: 'transparent' }
              Circle().width(32).height(32).fill('transparent')
              // === Circle ===
              // modifier: { width: 32, height: 32, stroke: { width: 2, color: '#F5F5F5' } }
              Circle().width(32).height(32).strokeWidth(2).stroke('#F5F5F5')
            }
          }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).border({ width: 1, color: '#F5F5F5', radius: 16 }).margin({ bottom: 8 })

          // === Component: HabitItem (Learn Spanish) ===
          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, border: { width: 1, color: '#F5F5F5', radius: 16 }, marginBottom: 8 }
          // children: 4
          Row({ space: 0 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 48, height: 48 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 48, height: 48, fill: '#F5F5F5' }
              Circle().width(48).height(48).fill('#F5F5F5')
              // === Image ===
              // modifier: { width: 24, height: 24, color: '#121212' }
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#121212')
            }

            // === Blank ===
            // modifier: { width: 16 }
            Blank().width(16)

            // === Column ===
            // props: { space: 0 }
            // modifier: { layoutWeight: 1 }
            // children: 3
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Learn Spanish' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#121212' }
              Text('Learn Spanish').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#121212')
              // === Blank ===
              // modifier: { height: 2 }
              Blank().height(2)
              // === Text ===
              // props: { text: 'Daily lesson completed' }
              // modifier: { fontSize: 12, color: '#757575' }
              Text('Daily lesson completed').fontSize(12).fontColor('#757575')
            }.layoutWeight(1)

            // === Blank ===
            // modifier: { width: 8 }
            Blank().width(8)

            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 32, height: 32 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 32, height: 32, fill: 'transparent' }
              Circle().width(32).height(32).fill('transparent')
              // === Circle ===
              // modifier: { width: 32, height: 32, stroke: { width: 2, color: '#F5F5F5' } }
              Circle().width(32).height(32).strokeWidth(2).stroke('#F5F5F5')
            }
          }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).border({ width: 1, color: '#F5F5F5', radius: 16 }).margin({ bottom: 8 })

          // === Component: HabitItem (Drink Water) ===
          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, border: { width: 1, color: '#F5F5F5', radius: 16 }, marginBottom: 8 }
          // children: 4
          Row({ space: 0 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 48, height: 48 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 48, height: 48, fill: '#F5F5F5' }
              Circle().width(48).height(48).fill('#F5F5F5')
              // === Image ===
              // modifier: { width: 24, height: 24, color: '#121212' }
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#121212')
            }

            // === Blank ===
            // modifier: { width: 16 }
            Blank().width(16)

            // === Column ===
            // props: { space: 0 }
            // modifier: { layoutWeight: 1 }
            // children: 3
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Drink Water' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, color: '#121212' }
              Text('Drink Water').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#121212')
              // === Blank ===
              // modifier: { height: 2 }
              Blank().height(2)
              // === Text ===
              // props: { text: '2L target' }
              // modifier: { fontSize: 12, color: '#757575' }
              Text('2L target').fontSize(12).fontColor('#757575')
            }.layoutWeight(1)

            // === Blank ===
            // modifier: { width: 8 }
            Blank().width(8)

            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 32, height: 32 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 32, height: 32, fill: 'transparent' }
              Circle().width(32).height(32).fill('transparent')
              // === Circle ===
              // modifier: { width: 32, height: 32, stroke: { width: 2, color: '#F5F5F5' } }
              Circle().width(32).height(32).strokeWidth(2).stroke('#F5F5F5')
            }
          }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).border({ width: 1, color: '#F5F5F5', radius: 16 }).margin({ bottom: 8 })

          // === Blank ===
          // modifier: { height: 24 }
          Blank().height(24)

          // === Component: Inspiration Section ===
          // === Column ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: 20, backgroundColor: '#F5F5F5', borderRadius: 16 }
          // children: 3
          Column({ space: 0 }) {
            // === Image ===
            // modifier: { width: 20, height: 20, color: '#757575' }
            Image($r('app.media.startIcon')).width(20).height(20).fillColor('#757575')
            // === Blank ===
            // modifier: { height: 12 }
            Blank().height(12)
            // === Text ===
            // props: { text: 'Small steps every day add up to big results over time.' }
            // modifier: { fontSize: 14, fontStyle: FontStyle.Italic, color: '#121212', lineHeight: 20 }
            Text('Small steps every day add up to big results over time.').fontSize(14).fontStyle(FontStyle.Italic).fontColor('#121212').lineHeight(20)
          }.width('100%').padding(20).backgroundColor('#F5F5F5').borderRadius(16)

          // === Blank ===
          // modifier: { height: 48 }
          Blank().height(48)
        }.width('100%').padding(24)
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}