Looking at the error, the issue is with untyped object literals at line 4. Let me read the current file to understand what's there.

<function_calls>
<invoke name="Read">
<parameter name="file_path">C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Read">
<parameter name="file_path">C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets</parameter>
<parameter name="start_line">1</parameter>
<parameter name="end_line">50</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">cat -n "C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets" 2>/dev/null || cat "C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets" | head -50</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">head -50 /e/IdeaProjects/GolandProjects/webhooks/Index.ets</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">cat /e/IdeaProjects/GolandProjects/webhooks/Index.ets</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">ls /e/IdeaProjects/GolandProjects/webhooks/</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">find /e/IdeaProjects/GolandProjects/webhooks -name "*.ets" 2>/dev/null | head -20</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">find /e/IdeaProjects/GolandProjects/webhooks -type f 2>/dev/null | head -30</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">ls /e/IdeaProjects/GolandProjects/webhooks/ 2>/dev/null && echo "found" || echo "not found"</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">cmd.exe /c "dir C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/*.ets /s 2>&1"</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">cmd.exe /c "type C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets 2>&1" | head -60</parameter>
</invoke>
</function_calls>
<function_calls>
<invoke name="Bash">
<parameter name="command">cmd.exe /c "type C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets" 2>&1</parameter>
</invoke>
</function_calls>

Now I have the full file. The errors are:
1. Untyped object literals (line 4 - `pins` array uses object literals without explicit class)
2. `ButtonAttribute` being passed where string/builder expected

Let me write the corrected ArkTS code:

<function_calls>
<invoke name="Write">
<parameter name="file_path">C:/Users/ASUS/Documents/Codes/SIRGroup/ArkTransAbout/ArkTrans-main/evaluate/etssingleui/entry/src/main/ets/pages/Index.ets</parameter>
<parameter name="content">// Approval Flow - ArkTS

class ApprovalPin {
  id: number = 0
  title: string = ''
  status: string = ''
  x: number = 0
  y: number = 0
}

// Color tokens
const COLOR_PRIMARY: string = '#FF111111'
const COLOR_SECONDARY: string = '#FF2A2A2A'
const COLOR_BACKGROUND: string = '#FFF7F7F7'
const COLOR_SURFACE: string = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT: string = '#FFEDEDED'
const COLOR_OUTLINE: string = '#FFD6D6D6'
const COLOR_SUCCESS: string = '#FF1E7D4C'
const COLOR_WARNING: string = '#FFB98400'
const COLOR_ERROR: string = '#FFB3261E'
const COLOR_ON_PRIMARY: string = '#FFFFFFFF'
const COLOR_ON_SURFACE: string = '#FF0A0A0A'

function pinColor(status: string): string {
  if (status === 'Approved') return COLOR_SUCCESS
  if (status === 'Pending') return COLOR_WARNING
  return COLOR_ERROR
}

@Entry
@Component
struct Index {
  @State activeFilters: string[] = ['Pending']
  @State selectedId: number = -1

  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = (() => {
    const p1 = new ApprovalPin()
    p1.id = 1; p1.title = 'Purchase Order #1042'; p1.status = 'Pending'; p1.x = 0.18; p1.y = 0.35
    const p2 = new ApprovalPin()
    p2.id = 2; p2.title = 'Travel Request #552'; p2.status = 'Approved'; p2.x = 0.52; p2.y = 0.42
    const p3 = new ApprovalPin()
    p3.id = 3; p3.title = 'Contract #A77'; p3.status = 'Pending'; p3.x = 0.76; p3.y = 0.58
    const p4 = new ApprovalPin()
    p4.id = 4; p4.title = 'Budget Change #09'; p4.status = 'Rejected'; p4.x = 0.33; p4.y = 0.72
    return [p1, p2, p3, p4]
  })()

  isFilterActive(f: string): boolean {
    return this.activeFilters.indexOf(f) >= 0
  }

  toggleFilter(f: string): void {
    const idx = this.activeFilters.indexOf(f)
    if (idx >= 0) {
      this.activeFilters = this.activeFilters.filter((x: string) => x !== f)
    } else {
      this.activeFilters = [...this.activeFilters, f]
    }
  }

  isPinVisible(p: ApprovalPin): boolean {
    if (p.status === 'Pending') return this.isFilterActive('Pending')
    if (p.status === 'Approved') return this.isFilterActive('Approved')
    return true
  }

  getSelectedPin(): ApprovalPin | null {
    if (this.selectedId === -1) return null
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedId) return this.pins[i]
    }
    return null
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(COLOR_SURFACE_VARIANT)
            .strokeWidth(1)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceEvenly)

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(COLOR_SURFACE_VARIANT)
            .strokeWidth(1)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      // Content
      Column({ space: 12 }) {
        // Filter chips
        Row({ space: 8 }) {
          ForEach(this.filters, (f: string) => {
            Text(f)
              .fontSize(this.isFilterActive(f) ? 16 : 14)
              .fontWeight(this.isFilterActive(f) ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.isFilterActive(f) ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
              .backgroundColor(this.isFilterActive(f) ? COLOR_PRIMARY : COLOR_SURFACE)
              .borderRadius(8)
              .border({ width: 1, color: COLOR_OUTLINE })
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .onClick(() => {
                this.toggleFilter(f)
              })
          }, (f: string) => f)
        }
        .width('100%')

        // Map area
        Stack() {
          // Background
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(16)
            .border({ width: 1, color: COLOR_OUTLINE })

          // Grid overlay
          this.MapGridOverlay()

          // Pins
          ForEach(this.pins.filter((p: ApprovalPin) => this.isPinVisible(p)), (p: ApprovalPin) => {
            Stack() {
              // Pin dot
              Circle()
                .width(this.selectedId === p.id ? 28 : 22)
                .height(this.selectedId === p.id ? 28 : 22)
                .fill(pinColor(p.status))
                .stroke(this.selectedId === p.id ? COLOR_PRIMARY : COLOR_SURFACE)
                .strokeWidth(2)

              // Label card
              Text(p.title)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
                .backgroundColor(COLOR_SURFACE)
                .borderRadius(8)
                .border({ width: 1, color: COLOR_OUTLINE })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ left: this.selectedId === p.id ? 32 : 26, top: 0 })
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
                .onClick(() => {
                  this.selectedId = (this.selectedId === p.id) ? -1 : p.id
                })
            }
            .alignContent(Alignment.TopStart)
            .position({ x: `${p.x * 100}%`, y: `${p.y * 100}%` })
          }, (p: ApprovalPin) => p.id.toString())

          // Selected pin detail card
          if (this.selectedId !== -1 && this.getSelectedPin() !== null) {
            Row() {
              Column({ space: 4 }) {
                Text(this.getSelectedPin()!.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)
                Text(this.getSelectedPin()!.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('Details')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
                .backgroundColor(COLOR_SURFACE_VARIANT)
                .borderRadius(12)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .height(40)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(16)
            .border({ width: 1, color: COLOR_OUTLINE })
            .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
            .position({ x: '0%', y: '100%' })
            .markAnchor({ x: 0, y: '100%' })
            .margin({ bottom: 12, left: 12, right: 12 })
          }
        }
        .width('100%')
        .aspectRatio(0.9)
        .clip(true)
        .borderRadius(16)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      Row({ space: 12 }) {
        Text('Reject')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedId !== -1 ? COLOR_ON_SURFACE : '#88000000')
          .backgroundColor(this.selectedId !== -1 ? COLOR_SURFACE_VARIANT : '#FFDDDDDD')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .enabled(this.selectedId !== -1)

        Text('Approve')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedId !== -1 ? COLOR_ON_PRIMARY : '#88FFFFFF')
          .backgroundColor(this.selectedId !== -1 ? COLOR_PRIMARY : '#FF888888')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .enabled(this.selectedId !== -1)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    // FAB
    .bindContentCover(undefined, undefined)
    .overlay(
      Stack() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_PRIMARY)
          .width(56)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(28)
          .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.BottomEnd)
      .padding({ right: 16, bottom: 80 }),
      { align: Alignment.TopStart }
    )
  }
}
</parameter>
</invoke>
</function_calls>

The key fixes applied:

1. **Untyped object literals** — replaced `{ id: 1, title: '...', ... }` array literals with explicit `ApprovalPin` class instances using `new ApprovalPin()` and property assignment.

2. **`ButtonAttribute` error** — replaced all `Button()` components with `Text()` styled as buttons (background, borderRadius, padding), avoiding the ArkTS builder-slot type mismatch.

3. **`selectedId`** — changed from `number | null` to `number` with `-1` as sentinel, since ArkTS `@State` doesn't support nullable union types cleanly.

4. **`getSelectedPin()`** — extracted as a method returning `ApprovalPin | null` to avoid repeated null-check inline expressions that ArkTS rejects.

5. **ForEach key functions** — typed explicitly as `(item: number) => item.toString()` and `(f: string) => f` to satisfy ArkTS strict typing.