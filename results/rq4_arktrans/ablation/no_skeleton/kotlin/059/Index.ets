interface Medicine {
  name: string;
  time: string;
}

@Entry
@Component
struct MedicineReminder {
  @State medicines: Array<Medicine> = [
    { name: 'Vitamin C', time: '08:00 AM' },
    { name: 'Aspirin', time: '12:30 PM' },
    { name: 'Insulin', time: '06:00 PM' },
    { name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F9FAFB' }
      // children: 2
      Column({ space: 12 }) {
        // === Text ===
        // props: { text: 'Medicine Reminder' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#111827', textAlign: TextAlign.Center }
        Text('Medicine Reminder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)

        // === List ===
        // props: { space: 12 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 4
        List({ space: 12 }) {
          ForEach(this.medicines, (item: Medicine) => {
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
                  // props: { text: item.name }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937' }
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1F2937')

                  // === Text ===
                  // props: { text: item.time }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1F2937' }
                  Text(item.time)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#1F2937')
                }

                // === Circle ===
                // modifier: { width: 16, height: 16, backgroundColor: '#111827', borderRadius: 8 }
                Circle()
                  .width(16)
                  .height(16)
                  .fill('#111827')
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFF')
              .borderRadius(12)
              .border({ width: 1, color: '#D1D5DB' })
            }
          }, (item: Medicine) => JSON.stringify(item))
        }
        .width('100%')
        .layoutWeight(1)

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
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F9FAFB')

      // === BottomBar ===
      // modifier: { width: '100%', height: 64, backgroundColor: '#E5E7EB' }
      // children: 1
      Row() {
        // === Text ===
        // props: { text: 'Today' }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#111827', layoutWeight: 1, textAlign: TextAlign.Center }
        Text('Today')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // === Text ===
        // props: { text: 'History' }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937', layoutWeight: 1, textAlign: TextAlign.Center }
        Text('History')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // === Text ===
        // props: { text: 'Profile' }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#1F2937', layoutWeight: 1, textAlign: TextAlign.Center }
        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor('#E5E7EB')

      // === FAB ===
      // modifier: { width: 56, height: 56, backgroundColor: '#111827', borderRadius: 28, margin: 24, shadow: { radius: 8, color: '#3F000000' } }
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
      .margin({ right: 24, bottom: 88 })
      .shadow({ radius: 8, color: '#3F000000' })
    }
    .width('100%')
    .height('100%')
  }
}