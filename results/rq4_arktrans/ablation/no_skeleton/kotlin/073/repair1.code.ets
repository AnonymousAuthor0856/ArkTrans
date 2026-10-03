import { FontWeight, ItemAlign, VerticalAlign } from '@kit.ArkUI'

interface FilterChipParams {
  label: string
  isActive: boolean
}

interface SummaryBlockParams {
  title: string
  value: string
  accent: string
}

interface ChatThreadCardParams {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live'
  @State draftText: string = ''

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Scrollable Content Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', height: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 }, backgroundColor: '#050714' }
      // children: 5
      Column() {
        // === Top Bar Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center, marginBottom: 12 }
        // children: 3
        Row() {
          // === Text (Hub) ===
          // props: { text: 'Hub' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0', width: 40 }
          Text('Hub')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .width(40)

          // === Column (Title & Subtitle) ===
          // props: { space: 4 }
          // modifier: { layoutWeight: 1 }
          // children: 2
          Column() {
            // === Text (HoloChat Dock) ===
            // props: { text: 'HoloChat Dock' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
            Text('HoloChat Dock')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')

            // === Text (Dark neon bridge) ===
            // props: { text: 'Dark neon bridge' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#94A3B8' }
            Text('Dark neon bridge')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#94A3B8')
          }

          // === Text (Status) ===
          // props: { text: 'Status' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#22D3EE', width: 40, textAlign: TextAlign.End }
          Text('Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#22D3EE')
            .width(40)
            .textAlign(TextAlign.End)
        }

        // === Filter Chips Row ===
        // props: { space: 8 }
        // modifier: { width: '100%', marginBottom: 12 }
        // children: 4
        Row() {
          this.FilterChip({ label: 'Live', isActive: true })
          this.FilterChip({ label: 'Pinned', isActive: false })
          this.FilterChip({ label: 'Escalated', isActive: false })
          this.FilterChip({ label: 'Silent', isActive: false })
        }

        // === Status Summary Row ===
        // props: { space: 8 }
        // modifier: { width: '100%', marginBottom: 12 }
        // children: 3
        Row() {
          this.SummaryBlock({ title: 'LIVE DOCKS', value: '12', accent: '#22D3EE' })
          this.SummaryBlock({ title: 'ESCALATIONS', value: '3', accent: '#F97316' })
          this.SummaryBlock({ title: 'QUEUED', value: '5', accent: '#7C3AED' })
        }

        // === Chat Threads List ===
        // props: { space: 12 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 3
        Column() {
          this.ChatThreadCard({ name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true })
          this.ChatThreadCard({ name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false })
          this.ChatThreadCard({ name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true })
        }

        // === Action Footer Card ===
        // modifier: { width: '100%', marginTop: 12, marginBottom: 80 }
        // children: 1
        Column() {
          // === Column (Footer Content) ===
          // props: { space: 8 }
          // modifier: { width: '100%', padding: 16, backgroundColor: '#1F2937', borderRadius: 20 }
          // children: 2
          Column() {
            // === Text (Dock filters) ===
            // props: { text: 'Dock filters' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
            Text('Dock filters')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')

            // === Row (Buttons) ===
            // props: { space: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Row() {
              // === Button (Calm) ===
              // props: { type: ButtonType.Capsule }
              // modifier: { width: '50%', backgroundColor: '#7C3AED', fontColor: '#050714', borderRadius: 16 }
              // children: 1
              Button() {
                // === Text (Calm) ===
                // props: { text: 'Calm' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#050714' }
                Text('Calm')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#050714')
              }.type(ButtonType.Capsule).backgroundColor('#7C3AED').borderRadius(16).width('50%')

              // === Button (Fire) ===
              // props: { type: ButtonType.Capsule }
              // modifier: { width: '50%', backgroundColor: '#F97316', fontColor: '#110200', borderRadius: 16 }
              // children: 1
              Button() {
                // === Text (Fire) ===
                // props: { text: 'Fire' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#110200' }
                Text('Fire')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#110200')
              }.type(ButtonType.Capsule).backgroundColor('#F97316').borderRadius(16).width('50%')
            }
          }
        }.width('100%').margin({ top: 12, bottom: 80 })
      }.width('100%').height('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 }).backgroundColor('#050714')

      // === Floating Action Button ===
      // modifier: { width: 56, height: 56, backgroundColor: '#7C3AED', borderRadius: 16, shadow: { radius: 6, color: '#3F000000' }, margin: 24 }
      // children: 1
      Button() {
        // === Text (New) ===
        // props: { text: 'New' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#050714' }
        Text('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#050714')
      }.width(56).height(56).backgroundColor('#7C3AED').borderRadius(16).shadow({ radius: 6, color: '#3F000000' }).margin(24)

      // === Bottom Input Bar ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#1F2937', padding: { left: 16, right: 16, top: 16, bottom: 16 }, alignItems: ItemAlign.Center }
      // children: 2
      Column() {
        // === Row (Input & Send) ===
        // props: { space: 8 }
        // modifier: { width: '100%', height: 48, alignItems: ItemAlign.Center }
        // children: 2
        Row() {
          // === TextInput (Message dock...) ===
          // props: { placeholder: 'Message dock...' }
          // modifier: { width: '100%', height: 48, backgroundColor: '#0F172A', borderRadius: 16, padding: { left: 16, right: 16 }, fontColor: '#E2E8F0', placeholderColor: '#94A3B8' }
          TextInput({ placeholder: 'Message dock...' })
            .width('100%')
            .height(48)
            .backgroundColor('#0F172A')
            .borderRadius(16)
            .padding({ left: 16, right: 16 })
            .fontColor('#E2E8F0')
            .placeholderColor('#94A3B8')

          // === Button (Send) ===
          // props: { type: ButtonType.Capsule }
          // modifier: { width: 80, height: 48, backgroundColor: '#7C3AED', fontColor: '#050714', borderRadius: 16 }
          // children: 1
          Button() {
            // === Text (Send) ===
            // props: { text: 'Send' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#050714' }
            Text('Send')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#050714')
          }.type(ButtonType.Capsule).width(80).height(48).backgroundColor('#7C3AED').borderRadius(16)
        }
      }.width('100%').height(80).backgroundColor('#1F2937').padding({ left: 16, right: 16, top: 16, bottom: 16 }).alignItems(HorizontalAlign.Center)
    }.width('100%').height('100%')
  }

  @Builder
  FilterChip(params: FilterChipParams) {
    // === Button (Chip) ===
    // props: { type: ButtonType.Capsule }
    // modifier: { width: '25%', backgroundColor: params.isActive ? '#22D3EE' : '#1F2937', fontColor: params.isActive ? '#011014' : '#E2E8F0', borderRadius: 12 }
    // children: 1
    Button() {
      // === Text (Label) ===
      // props: { text: params.label }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: params.isActive ? '#011014' : '#E2E8F0' }
      Text(params.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(params.isActive ? '#011014' : '#E2E8F0')
    }.type(ButtonType.Capsule).width('25%').backgroundColor(params.isActive ? '#22D3EE' : '#1F2937').borderRadius(12)
  }

  @Builder
  SummaryBlock(params: SummaryBlockParams) {
    // === Column (Summary Block) ===
    // props: { space: 4 }
    // modifier: { width: '33.33%', backgroundColor: '#0F172A', borderRadius: 16, padding: 12 }
    // children: 3
    Column() {
      // === Circle (Accent) ===
      // modifier: { width: 12, height: 12, backgroundColor: params.accent, borderRadius: 6 }
      Image('').width(12).height(12).backgroundColor(params.accent).borderRadius(6)

      // === Text (Title) ===
      // props: { text: params.title }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#94A3B8' }
      Text(params.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#94A3B8')

      // === Text (Value) ===
      // props: { text: params.value }
      // modifier: { fontSize: 28, fontWeight: FontWeight.SemiBold, fontColor: params.accent }
      Text(params.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(params.accent)
    }.width('33.33%').backgroundColor('#0F172A').borderRadius(16).padding(12)
  }

  @Builder
  ChatThreadCard(params: ChatThreadCardParams) {
    // === Column (Card Container) ===
    // props: { space: 8 }
    // modifier: { width: '100%', backgroundColor: '#0F172A', borderRadius: 20, padding: 16, borderColor: '#334155', borderWidth: 1 }
    // children: 3
    Column() {
      // === Row (Header) ===
      // props: { space: 8 }
      // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
      // children: 2
      Row() {
        // === Column (Name & Status) ===
        // props: { space: 4 }
        // modifier: { layoutWeight: 1 }
        // children: 2
        Column() {
          // === Text (Name) ===
          // props: { text: params.name }
          // modifier: { fontSize: 22, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
          Text(params.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          // === Text (Status) ===
          // props: { text: params.status }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: params.isPriority ? '#22D3EE' : '#94A3B8' }
          Text(params.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(params.isPriority ? '#22D3EE' : '#94A3B8')
        }

        // === Badge (Unread/Check) ===
        // modifier: { width: 32, height: 32, backgroundColor: '#1F2937', borderRadius: 16, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
        // children: 1
        Row() {
          // === Text (Badge Content) ===
          // props: { text: params.unread > 0 ? '+' + params.unread.toString() : '✓' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
          Text(params.unread > 0 ? '+' + params.unread.toString() : '✓')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }.width(32).height(32).backgroundColor('#1F2937').borderRadius(16).justifyContent(FlexAlign.Center).alignItems(ItemAlign.Center)
      }

      // === Text (Snippet) ===
      // props: { text: params.snippet }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#CBD5E1' }
      Text(params.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#CBD5E1')

      // === Row (Actions) ===
      // props: { space: 8 }
      // modifier: { width: '100%' }
      // children: 2
      Row() {
        // === Tag (Priority/Standard) ===
        // modifier: { backgroundColor: '#1F2937', borderRadius: 12, padding: { left: 8, right: 8, top: 4, bottom: 4 } }
        // children: 1
        Row() {
          // === Text (Tag Label) ===
          // props: { text: params.isPriority ? 'Priority' : 'Standard' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
          Text(params.isPriority ? 'Priority' : 'Standard')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }.backgroundColor('#1F2937').borderRadius(12).padding({ left: 8, right: 8, top: 4, bottom: 4 })

        // === Button (Open) ===
        // props: { type: ButtonType.Capsule }
        // modifier: { width: 60, height: 24, backgroundColor: 'transparent', fontColor: '#22D3EE', borderRadius: 12 }
        // children: 1
        Button() {
          // === Text (Open) ===
          // props: { text: 'Open' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#22D3EE' }
          Text('Open')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#22D3EE')
        }.type(ButtonType.Capsule).width(60).height(24).backgroundColor('transparent').borderRadius(12)
      }
    }.width('100%').backgroundColor('#0F172A').borderRadius(20).padding(16).border({ width: 1, color: '#334155' })
  }
}