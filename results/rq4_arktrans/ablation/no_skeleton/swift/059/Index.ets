@Entry
@Component
struct RootScreen {
  @State medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.BottomEnd }
    // children: 3
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Column ===
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Column() {
        // === Scrollable Container (Simulating ScrollView) ===
        // modifier: { width: '100%', layoutWeight: 1, padding: { left: 16, right: 16, top: 16 } }
        // children: 2
        Column({ space: 12 }) {
          // === Text ===
          // props: { text: 'Medicine Reminder' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#111827' }
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')

          // === List ===
          // props: { space: 12 }
          // modifier: { width: '100%' }
          // children: 4
          List({ space: 12 }) {
            ForEach(this.medicines, (medicine: Medicine) => {
              ListItem() {
                // === Row ===
                // props: { space: 12 }
                // modifier: { width: '100%', padding: 12, backgroundColor: '#FFF', borderRadius: 12, borderColor: '#D1D5DB', borderWidth: 1 }
                // children: 2
                Row({ space: 12 }) {
                  // === Column ===
                  // props: { space: 4 }
                  // modifier: { layoutWeight: 1 }
                  // children: 2
                  Column({ space: 4 }) {
                    // === Text ===
                    // props: { text: medicine.name }
                    // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937' }
                    Text(medicine.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1F2937')
                    
                    // === Text ===
                    // props: { text: medicine.time }
                    // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1F2937' }
                    Text(medicine.time)
                      .fontSize(14)
                      .fontWeight(FontWeight.Normal)
                      .fontColor('#1F2937')
                  }

                  // === Circle (Simulated by Image or Shape) ===
                  // Using Image as per rules for resources, though a shape is also valid. 
                  // Since only $r('app.media.startIcon') exists, we use a generic placeholder or shape logic if allowed.
                  // However, to strictly follow "Images: ONLY $r... exists", and since this is a UI element, 
                  // I will use a standard ArkTS shape component which is preferred for UI elements like dots anyway.
                  // If forced to use Image, it would be Image('').circle(true).width(16).height(16).backgroundColor('#111827')
                  // But standard practice for a dot is a shape. Let's use a simple colored circle via Image with empty src or just a shape.
                  // The prompt says "Implement every child". The SwiftUI code uses Circle().fill().
                  // In ArkTS, we can use Image('').circle(true) or just a custom shape. 
                  // Given the constraint on images, I'll use a basic Image with no source but styled, or better yet, 
                  // since it's a UI control, a standard shape is best. But to be safe with the "Image" rule interpretation:
                  // I will use an Image component with an empty string source, styled as a circle.
                  Image('').width(16).height(16).borderRadius(8).backgroundColor('#111827')
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FFF')
                .borderRadius(12)
                .border({ width: 1, color: '#D1D5DB' })
              }
            })
          }.width('100%')

          // === Blank ===
          // Pushes button down
          Blank()

          // === Button ===
          // modifier: { width: '80%', height: 48, backgroundColor: '#374151', fontColor: '#FFF', borderRadius: 16 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Mark All Taken' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FFF' }
            Text('Mark All Taken')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFF')
          }
          .width('80%')
          .height(48)
          .backgroundColor('#374151')
          .borderRadius(16)
          .margin({ bottom: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 16 })
        .backgroundColor('#F9FAFB')

        // === BottomAppBar ===
        // modifier: { width: '100%', height: 56, backgroundColor: '#FFF', shadow: { radius: 8, color: '#24000000', offsetY: 4 } }
        // children: 1
        Row({ space: 12 }) {
          // === Text ===
          // props: { text: 'Today' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#111827' }
          Text('Today')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
          
          // === Blank ===
          Blank()

          // === Text ===
          // props: { text: 'History' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937' }
          Text('History')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
            
          // === Blank ===
          Blank()

          // === Text ===
          // props: { text: 'Profile' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937' }
          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFF')
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      // === FloatingActionButton ===
      // modifier: { width: 56, height: 56, backgroundColor: '#111827', borderRadius: 28, margin: 16 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: '+' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#FFF' }
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#111827')
      .borderRadius(28)
      .margin(16)
    }
    .width('100%')
    .height('100%')
  }
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}