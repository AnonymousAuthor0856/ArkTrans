@Entry
@Component
struct ReliefFundApp {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FBF8F3')

      // Main column
      Column({ space: 0 }) {
        // Header
        Row({ space: 0 }) {
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#EBE2D6')
            .borderRadius(24)
          Blank()
          Column({ space: 2 }) {
            Text('ReliefFund')
              .fontSize(19)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#3D352E')
            Text('Civic support intake')
              .fontSize(13)
              .foregroundColor('#8A8A8E')
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#EBE2D6')
            .borderRadius(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 10, bottom: 20 })

        // Scrollable content using List
        List({ space: 24 }) {
          // Applicant Details Card
          ListItem() {
            Column({ space: 16 }) {
              Text('Applicant details')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#3D352E')
                .width('100%')
                .padding({ bottom: 4 })

              // Form fields
              TextInput({ placeholder: 'Full name', text: this.fullName })
                .fontSize(16)
                .foregroundColor('#3D352E')
                .padding({ left: 16, right: 16 })
                .height(48)
                .backgroundColor('#FBF8F3')
                .borderRadius(16)
                .border({ width: 1.5, color: '#C5B8A9', radius: 16 })
                .onChange((val: string) => { this.fullName = val })

              TextInput({ placeholder: 'Organization', text: this.organization })
                .fontSize(16)
                .foregroundColor('#3D352E')
                .padding({ left: 16, right: 16 })
                .height(48)
                .backgroundColor('#FBF8F3')
                .borderRadius(16)
                .border({ width: 1.5, color: '#C5B8A9', radius: 16 })
                .onChange((val: string) => { this.organization = val })

              TextInput({ placeholder: 'Contact', text: this.contact })
                .fontSize(16)
                .foregroundColor('#3D352E')
                .padding({ left: 16, right: 16 })
                .height(48)
                .backgroundColor('#FBF8F3')
                .borderRadius(16)
                .border({ width: 1.5, color: '#C5B8A9', radius: 16 })
                .onChange((val: string) => { this.contact = val })

              // Narrative field (multiline)
              TextInput({ placeholder: 'Relief narrative', text: this.narrative })
                .fontSize(16)
                .foregroundColor('#3D352E')
                .padding({ left: 16, right: 16 })
                .height(180)
                .backgroundColor('#FBF8F3')
                .borderRadius(16)
                .border({ width: 1.5, color: '#C5B8A9', radius: 16 })
                .maxLines(5)
                .onChange((val: string) => { this.narrative = val })

              // Navigation Buttons
              Row({ space: 2 }) {
                Button() {
                  Text('Back')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#000000')
                    .height(56)
                    .width('100%')
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .height(56)
                .backgroundColor('#EBE2D6')
                .borderRadius(16)
                .onClick(() => {
                  // Back action
                })

                Button() {
                  Text('Next')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#000000')
                    .height(56)
                    .width('100%')
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .height(56)
                .backgroundColor('#B58B5A')
                .borderRadius(16)
                .onClick(() => {
                  // Next action
                })
              }
              .width('100%')
              .margin({ top: 80 })
            }
            .padding(24)
            .backgroundColor('#F7F3EE')
            .borderRadius(32)
            .width('100%')
          }

          // Summary Card
          ListItem() {
            Column({ space: 16 }) {
              Text('Summary')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#3D352E')
                .width('100%')

              // Summary Row
              Row({ space: 0 }) {
                Text('Requested')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#3D352E')
                Blank()
                Text('$4,500')
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#000000')
              }
              .width('100%')
              .padding(20)
              .backgroundColor('#EBE2D6')
              .borderRadius(16)
            }
            .padding(24)
            .backgroundColor('#F7F3EE')
            .borderRadius(32)
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}