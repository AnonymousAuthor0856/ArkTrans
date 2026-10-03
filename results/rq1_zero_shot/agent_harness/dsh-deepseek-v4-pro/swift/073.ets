// Translated from SwiftUI (073.swift) to ArkTS / ArkUI

// MARK: - App Tokens & Colors
const C_PRIMARY = '#7C3AED';
const C_SECONDARY = '#22D3EE';
const C_TERTIARY = '#F97316';
const C_BACKGROUND = '#050714';
const C_SURFACE = '#0F172A';
const C_SURFACE_VARIANT = '#1F2937';
const C_OUTLINE = '#334155';
const C_ON_PRIMARY = '#050714';
const C_ON_SECONDARY = '#011014';
const C_ON_TERTIARY = '#110200';
const C_ON_BACKGROUND = '#F8FAFC';
const C_ON_SURFACE = '#E2E8F0';

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

// MARK: - Root View
@Component
struct ContentView {
  build() {
    HoloChatDockScreen()
    // .preferredColorScheme(.dark)
    // .statusBarHidden(true)
  }
}

// MARK: - Models
class ChatThread {
  id: string;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;

  constructor(id: string, name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.unread = unread;
    this.snippet = snippet;
    this.isPriority = isPriority;
  }
}

// MARK: - Main Screen
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  threads: ChatThread[] = [
    new ChatThread('1', 'Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('2', 'Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('3', 'Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        CustomTopBar()

        // Content
        Scroll() {
          Column({ space: 12 }) {
            // Filters
            Scroll() {
              Row({ space: 8 }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    action: () => { this.activeFilter = filter }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: 16, right: 16 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            // Status Summary
            StatusSummary()
              .padding({ left: 16, right: 16 })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: 16, right: 16 })
            }, (thread: ChatThread) => thread.id)

            // Action Footer
            ActionFooter()
              .padding({ left: 16, right: 16 })

            // Spacer for bottom bar + FAB area
            Blank().height(100)
          }
          .padding({ top: 12, bottom: 12 })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text('New')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_PRIMARY)
              .padding({ left: 16, right: 16, top: 16, bottom: 16 })
              .backgroundColor(C_PRIMARY)
              .borderRadius(16)
              .shadow({ radius: 4, color: '#000000' })
          }
          .onClick(() => {})
          .padding({ right: 16, bottom: 80 }) // Lift above bottom bar
        }
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      BottomInputBar({ text: $this.draftMessage })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
    // .statusBarHidden(true)
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button() {
        Text('Hub')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
      }
      .onClick(() => {})

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_SECONDARY)
      }
      .onClick(() => {})
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(C_SURFACE)
  }
}

@Component
struct AssistChip {
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  action: () => void = () => {}

  build() {
    Button() {
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? C_ON_SECONDARY : C_ON_SURFACE)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(this.isSelected ? C_SECONDARY : C_SURFACE_VARIANT)
        .borderRadius(12)
        .border({ width: this.isSelected ? 0 : 1, color: C_OUTLINE })
    }
    .onClick(() => { this.action() })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: 8 }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: C_SECONDARY })
      SummaryBlock({ title: 'Escalations', value: '3', accent: C_TERTIARY })
      SummaryBlock({ title: 'Queued', value: '5', accent: C_PRIMARY })
    }
  }
}

@Component
struct SummaryBlock {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop accent: string = ''

  build() {
    Column({ space: 4 }) {
      Blank().width(12).height(12).backgroundColor(this.accent).borderRadius(6)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SURFACE)
        .opacity(0.7)

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Semibold)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .layoutWeight(1)
    .backgroundColor(C_SURFACE)
    .borderRadius(16)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread('', '', '', 0, '', false)

  build() {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? C_SECONDARY : C_ON_SURFACE)
            .opacity(this.thread.isPriority ? 1 : 0.7)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.thread.unread > 0 ? '+' + this.thread.unread : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(12)
      }

      Text(this.thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(C_ON_SURFACE)
        .opacity(0.9)

      Row({ space: 8 }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(12)

        Button() {
          Text('Open')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_SECONDARY)
        }
        .onClick(() => {})
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .backgroundColor(C_SURFACE)
    .borderRadius(20)
    .border({ width: 1, color: C_OUTLINE })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SURFACE)

      Row({ space: 8 }) {
        Button() {
          Text('Calm')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_PRIMARY)
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .backgroundColor(C_PRIMARY)
            .borderRadius(16)
        }
        .onClick(() => {})

        Button() {
          Text('Fire')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_TERTIARY)
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .backgroundColor(C_TERTIARY)
            .borderRadius(16)
        }
        .onClick(() => {})
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(C_SURFACE_VARIANT)
    .borderRadius(20)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: 8 }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text === '') {
          Text('Message dock...')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_SURFACE)
            .opacity(0.6)
            .padding({ left: 12, right: 12 })
        }
        TextInput({ placeholder: '', text: this.text })
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(C_ON_SURFACE)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .onChange((value: string) => {
            this.text = value
          })
      }
      .height(48)
      .layoutWeight(1)
      .backgroundColor(C_SURFACE)
      .borderRadius(16)

      Button() {
        Text('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_PRIMARY)
          .padding({ left: 20, right: 20 })
          .height(48)
          .backgroundColor(C_PRIMARY)
          .borderRadius(16)
      }
      .onClick(() => {})
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(C_SURFACE_VARIANT)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }
}
