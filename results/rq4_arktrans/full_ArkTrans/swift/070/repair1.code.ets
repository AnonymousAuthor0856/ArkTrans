@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Circle().width(44).height(44).fill('#EEE9FC')
          Blank()
          Column({ space: 2 }) {
            Text('LeaseWizard').fontColor('#000000').fontSize(18).fontWeight(FontWeight.Bold)
            Text('Guided handoff').fontColor('#7A7A7A').fontSize(13).fontWeight(FontWeight.Regular)
          }
          Blank()
          Circle().width(44).height(44).fill('#EEE9FC')
        }.padding({ left: 20, right: 20 })

        Scroll() {
          Column({ space: 24 }) {
            // Steps Card
            Column({ space: 20 }) {
              Text('Steps').fontColor('#1E1E1E').fontSize(22).fontWeight(FontWeight.Bold)
              
              Column() {
                this.StepItem(1, 'Profile', 'Tenant basics', 'Edit', true)
                this.StepItem(2, 'Income', 'Proof details', 'Edit', true)
                this.StepItem(3, 'References', 'Upload letters', 'Go', false)
                this.StepItem(4, 'Summary', 'Confirm submission', 'Go', false)
              }
            }.width('100%').backgroundColor('#F5F3FF').borderRadius(24).padding(24)

            // Form Card
            Column({ space: 25 }) {
              Text('Form').fontColor('#1E1E1E').fontSize(22).fontWeight(FontWeight.Bold)
              
              this.FormField('Full name', 'Avery Tenant')
              this.FormField('Contact', 'avery@example.com')
            }.width('100%').backgroundColor('#F5F3FF').borderRadius(24).padding(24)
          }.padding({ left: 16, right: 16, bottom: 40 })
        }.layoutWeight(1)
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  @Builder
  StepItem(stepNum: number, title: string, subtitle: string, btnText: string, isActive: boolean) {
    Row({ space: 16 }) {
      Column() {
        Stack() {
          Circle().width(32).height(32).fill(isActive ? '#A07CFF' : '#EBE7F6')
          Text(stepNum.toString()).fontColor(isActive ? '#FFFFFF' : '#1E1E1E').fontSize(14).fontWeight(FontWeight.Medium)
        }
        if (stepNum < 4) {
          Rect().width(2).height(40).fill('#EEE9FC')
        }
      }.width(32)

      Column({ space: 2 }) {
        Text(title).fontColor('#1E1E1E').fontSize(17).fontWeight(FontWeight.Medium).margin({ top: 4 })
        Text(subtitle).fontColor('#7A7A7A').fontSize(15).fontWeight(FontWeight.Regular)
        Blank().height(24)
      }.layoutWeight(1)

      Button(btnText) {
        Text(btnText).fontColor('#1E1E1E').fontSize(16)
      }.backgroundColor('#F4ABD0').borderRadius(12).margin({ top: 2 })
    }
  }

  @Builder
  FormField(label: string, value: string) {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Text(value).fontColor('#1E1E1E').fontSize(18).fontWeight(FontWeight.Regular).layoutWeight(1)
        Blank()
        Rect().width(20).height(20).borderRadius(12).border({ width: 1, color: '#C4B5FD' })
      }.width('100%').padding(16).borderRadius(12).border({ width: 1, color: '#C4B5FD' }).backgroundColor('#F5F3FF')

      Text(label)
        .fontColor('#7A7A7A')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .backgroundColor('#F5F3FF')
        .padding({ left: 4, right: 4 })
        .position({ x: 12, y: -10 })
    }
  }
}