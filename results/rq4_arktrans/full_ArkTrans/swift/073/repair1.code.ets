@Entry
@Component
struct Index {
  @State text: string = ''

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Text('Hub').fontColor('#E2E8F0').fontSize(16).fontWeight(FontWeight.Medium)
          Blank()
          Column({ space: 4 }) {
            Text('HoloChat Dock').fontColor('#E2E8F0').fontSize(16).fontWeight(FontWeight.Bold)
            Text('Dark neon bridge').fontColor('#94A3B8').fontSize(12)
          }
          Blank()
          Text('Status').fontColor('#22D3EE').fontSize(16).fontWeight(FontWeight.Medium)
        }.width('100%').padding({ left: 16, right: 16, top: 16, bottom: 12 }).backgroundColor('#0F172A')

        Scroll() {
          Column({ space: 16 }) {
            // Filters
            Scroll() {
              Row({ space: 12 }) {
                this.FilterChip('Live', true)
                this.FilterChip('Pinned', false)
                this.FilterChip('Escalated', false)
                this.FilterChip('Silent', false)
              }.padding({ left: 16, right: 16 })
            }.scrollable(ScrollDirection.Horizontal).width('100%')

            // Summary Blocks
            Row({ space: 12 }) {
              this.SummaryBlock('LIVE DOCKS', '12', '#22D3EE')
              this.SummaryBlock('ESCALATIONS', '3', '#F97316')
              this.SummaryBlock('QUEUED', '5', '#A855F7')
            }.width('100%').padding({ left: 16, right: 16 })

            // Thread Cards
            this.ThreadCard('Orbital Finance', 'Rolling sync', 'Need rates for Q4', true, '+5')
            this.ThreadCard('Beacon Ops', 'Docked', 'Switching to holo feed', false, '✓')
            
            // Nova Crew Card with New Button
            Stack() {
              this.ThreadCard('Nova Crew', 'Hotline', 'Uploading scan pack now', true, '+2')
              Button() {
                Text('New').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
              }.type(ButtonType.Normal).backgroundColor('#A855F7').borderRadius(20).width(80).height(80)
                .position({ x: 260, y: 60 })
            }

            // Dock Filters Section
            Column({ space: 12 }) {
              Text('Dock filters').fontColor('#E2E8F0').fontSize(16).fontWeight(FontWeight.Medium)
              Row({ space: 12 }) {
                Button() {
                  Text('Filter A').fontColor('#E2E8F0').fontSize(12)
                }.type(ButtonType.Normal).backgroundColor('#1E293B').borderRadius(8).height(36).padding({ left: 16, right: 16 })
                
                Button() {
                  Text('Filter B').fontColor('#E2E8F0').fontSize(12)
                }.type(ButtonType.Normal).backgroundColor('#1E293B').borderRadius(8).height(36).padding({ left: 16, right: 16 })
              }
            }.width('100%').padding(16).backgroundColor('#1E293B').borderRadius(16)

            Blank().height(100)
          }.padding({ top: 16, bottom: 16 })
        }.layoutWeight(1)
      }.width('100%').height('100%').backgroundColor('#0F172A')

      // Bottom Input Bar
      Row({ space: 12 }) {
        Stack() {
          Text('Message dock...').fontColor('#64748B').fontSize(14).position({ x: 16, y: 12 })
          TextInput({ placeholder: '' }).placeholderColor('#64748B').fontColor('#E2E8F0').fontSize(14)
            .backgroundColor('Transparent').height(48).layoutWeight(1).margin({ left: 16 })
        }.backgroundColor('#1E293B').borderRadius(24).layoutWeight(1).height(48)

        Button() {
          Text('Send').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
        }.type(ButtonType.Normal).backgroundColor('#A855F7').borderRadius(24).width(80).height(48)
      }.width('100%').padding(16).backgroundColor('#1E293B').shadow({ radius: 6, color: '#33000000' })
    }.width('100%').height('100%')
  }

  @Builder
  FilterChip(label: string, isSelected: boolean) {
    Button() {
      Text(label).fontColor(isSelected ? '#0F172A' : '#E2E8F0').fontSize(14).fontWeight(FontWeight.Medium)
    }.type(ButtonType.Normal)
      .backgroundColor(isSelected ? '#22D3EE' : '#1E293B')
      .borderRadius(12)
      .height(40)
      .padding({ left: 20, right: 20 })
  }

  @Builder
  SummaryBlock(title: string, value: string, accentColor: string) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Circle().width(8).height(8).fill(accentColor)
        Text(title).fontColor('#94A3B8').fontSize(12).fontWeight(FontWeight.Medium)
      }
      Text(value).fontColor(accentColor).fontSize(32).fontWeight(FontWeight.Bold)
    }.width('100%').padding(16).backgroundColor('#1E293B').borderRadius(16)
  }

  @Builder
  ThreadCard(name: string, status: string, snippet: string, isPriority: boolean, badgeText: string) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(name).fontColor('#E2E8F0').fontSize(20).fontWeight(FontWeight.Bold)
          Text(status).fontColor(isPriority ? '#22D3EE' : '#94A3B8').fontSize(14)
        }
        Blank()
        Text(badgeText).fontColor('#E2E8F0').fontSize(14).fontWeight(FontWeight.Medium)
          .backgroundColor('#1E293B').borderRadius(16).padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      
      Text(snippet).fontColor('#CBD5E1').fontSize(14)
      
      Row({ space: 12 }) {
        Text(isPriority ? 'Priority' : 'Standard').fontColor('#E2E8F0').fontSize(12).fontWeight(FontWeight.Medium)
          .backgroundColor('#1E293B').borderRadius(16).padding({ left: 12, right: 12, top: 6, bottom: 6 })
        
        Text('Open').fontColor('#22D3EE').fontSize(14).fontWeight(FontWeight.Medium)
      }
    }.width('100%').padding(16).backgroundColor('#1E293B').borderRadius(24)
      .border({ width: 1, color: Color.Gray })
  }
}