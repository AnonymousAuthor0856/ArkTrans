import { BusinessError } from '@kit.BasicServicesKit';

interface Note {
  id: number;
  title: string;
  content: string;
}

@Entry
@Component
struct HomeView {
  // Sample data matching the Kotlin source
  private notes: Note[] = [
    {
      id: 1,
      title: "Shopping List",
      content: "- Milk\n- Eggs\n- Bread\n- Butter"
    },
    {
      id: 2,
      title: "Meeting Notes",
      content: "Discussed **Q3 roadmap** and *budget*.\n\n1. Draft proposal\n2. Review with team"
    },
    {
      id: 3,
      title: "Ideas",
      content: "> The best way to predict the future is to invent it.\n\n— Alan Kay"
    }
  ];

  build() {
    Column() {
      // Top Bar (Simulated based on screenshot)
      Row() {
        Text("Easy Notes")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2328')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16 })
      .backgroundColor('#F0F2F5') // Light gray header background

      // Main Content Area
      Column() {
        // Search Bar
        Row() {
          Image($r('app.media.icon_search')) // Placeholder for search icon
            .width(24)
            .height(24)
            .fillColor('#5F6368')
          
          Text("Search")
            .fontSize(16)
            .fontColor('#5F6368')
            .margin({ left: 12 })
          
          Blank()
          
          Image($r('app.media.icon_search')) // Placeholder for trailing search icon
            .width(24)
            .height(24)
            .fillColor('#5F6368')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#F8F9FA') // SurfaceContainerLow equivalent
        .borderRadius(24)
        .padding({ left: 16, right: 16 })
        .margin({ top: 16, bottom: 16, left: 32, right: 32 })

        // Scrollable List of Notes
        List({ space: 12 }) {
          ForEach(this.notes, (note: Note) => {
            ListItem() {
              NoteCardItem({ note: note })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 12, right: 12, bottom: 20 })
        .listDirection(Axis.Vertical)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct NoteCardItem {
  @Prop note: Note = { id: 0, title: '', content: '' };

  build() {
    Column() {
      // Title
      if (this.note.title) {
        Text(this.note.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        if (this.note.content) {
          Column().margin({ top: 9 })
        }
      }

      // Content (Simulating Markdown rendering for specific styles)
      if (this.note.content) {
        Column() {
          // We parse the content string manually to apply styles similar to the screenshot
          // In a real app, you would use the @ohos/markdown component here
          this.renderMarkdownContent(this.note.content)
        }
        .lineHeight(24)
        .maxLines(6)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width('100%')
    .backgroundColor('#F3E5F5') // SurfaceContainer equivalent (Light Purple tint as per screenshot)
    .borderRadius(16)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }

  // Helper to render styled text based on simple markdown patterns found in sample data
  @Builder
  renderMarkdownContent(content: string) {
    // Split by newlines to handle list items and paragraphs
    const lines: string[] = content.split('\n');
    
    ForEach(lines, (line: string) => {
      if (line.trim() === "") {
        Column().height(8) // Spacer for empty lines
      } else if (line.startsWith("- ")) {
        // Bullet point
        Row() {
          Text("•")
            .fontSize(16)
            .margin({ right: 8 })
          Text(line.substring(2))
            .fontSize(16)
            .fontColor('#000000')
        }
      } else if (line.match(/^\d+\./)) {
        // Numbered list
        Row() {
          Text(line.match(/^\d+\./)?.[0] ?? '')
            .fontSize(16)
            .fontColor('#000000')
            .margin({ right: 4 })
          Text(line.replace(/^\d+\.\s*/, ''))
            .fontSize(16)
            .fontColor('#000000')
        }
      } else if (line.startsWith("> ")) {
        // Blockquote
        Row() {
          Column()
            .width(4)
            .backgroundColor('#E0E0E0')
            .borderRadius(2)
            .alignSelf(ItemAlign.Stretch)
            .margin({ right: 12 })
          
          Text(line.substring(2))
            .fontSize(16)
            .fontColor('#000000')
            .layoutWeight(1)
        }
      } else {
        // Regular text with potential bold/italic
        // Simple regex replacement for demo purposes
        let processedLine: string = line;
        // Handle Bold (**text**)
        if (processedLine.includes("**")) {
          const parts: string[] = processedLine.split(/\*\*(.*?)\*\*/);
          Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
            ForEach(parts, (part: string, index: number) => {
              if (index % 2 === 1) {
                // Bold part
                Text(part)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
              } else {
                // Normal part
                Text(part)
                  .fontSize(16)
                  .fontColor('#000000')
              }
            })
          }
        } else {
          Text(processedLine)
            .fontSize(16)
            .fontColor('#000000')
        }
      }
    })
  }
}