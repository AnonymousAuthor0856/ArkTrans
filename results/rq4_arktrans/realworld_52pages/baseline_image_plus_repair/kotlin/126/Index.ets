@Entry
@Component
struct BackupPage {
  @State exportState: 'IDLE' | 'EXPORTING' | 'EXPORTED' = 'IDLE';
  @State restoreState: 'IDLE' | 'RESTORING' | 'RESTORED' | 'FAILURE' = 'IDLE';

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor('#EADDFF')
          .margin({ right: 16 })
          .onClick(() => {
            // Back action
          })
          .borderRadius(24)
          .fontColor('#1C1B1F')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .type(ButtonType.Capsule)
          .scale({ x: -1, y: 1 }) // Flip arrow to point left if default is right, or use specific icon

        Text('Backup')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 40, bottom: 24, left: 16, right: 16 })

      Scroll() {
        Column() {
          // Export Section
          Column() {
            Row() {
              Text('📤')
                .fontSize(24)
                .margin({ right: 16 })

              Column() {
                Text('Export')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')

                Text('Save all your data as a JSON file')
                  .fontSize(14)
                  .fontColor('#49454F')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Button(this.exportState === 'IDLE' ? '▶ Export' : (this.exportState === 'EXPORTING' ? 'Exporting...' : '✓ Done'))
              .width('80%')
              .height(56)
              .backgroundColor('#6750A4')
              .margin({ top: 16, left: 'auto', right: 'auto' })
              .borderRadius(28)
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .enabled(this.exportState === 'IDLE')
              .onClick(() => {
                this.exportState = 'EXPORTING';
                setTimeout(() => {
                  this.exportState = 'EXPORTED';
                }, 2000);
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })

          // Restore Section
          Column() {
            Row() {
              Text('⬇')
                .fontSize(24)
                .margin({ right: 16 })

              Column() {
                Text('Restore')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')

                Text('Restore data from a backup file')
                  .fontSize(14)
                  .fontColor('#49454F')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Button(this.restoreState === 'IDLE' ? '▶ Restore' : (this.restoreState === 'RESTORING' ? 'Restoring...' : '✓ Done'))
              .width('80%')
              .height(56)
              .backgroundColor('#6750A4')
              .margin({ top: 16, left: 'auto', right: 'auto' })
              .borderRadius(28)
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .enabled(this.restoreState === 'IDLE')
              .onClick(() => {
                this.restoreState = 'RESTORING';
                setTimeout(() => {
                  this.restoreState = 'RESTORED';
                }, 2000);
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FD') // Light purple tint background
  }
}