@Entry
@Component
struct ForumPostPage {
  @State voteState: number = 1
  private post: Post = new Post(
    new Author('user/compose_master', AppTokens.Colors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  )
  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppTokens.Colors.secondary), '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppTokens.Colors.primary), '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18),
    new Reply(3, new Author('newbie/coder', AppTokens.Colors.warning), '2h ago',
      'I found it a bit overwhelming at first. Any tips for organizing the file?', 3)
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          // Back icon (custom drawn arrow-like lines)
          Column() {
            Canvas(this.canvasSettings)
              .onReady((ctx: CanvasRenderingContext2D) => {
                ctx.strokeStyle = AppTokens.Colors.primary
                ctx.lineWidth = 2
                ctx.beginPath()
                ctx.moveTo(0, 10)
                ctx.lineTo(20, 10)
                ctx.stroke()
                ctx.beginPath()
                ctx.moveTo(0, 10)
                ctx.lineTo(10, 0)
                ctx.stroke()
                ctx.beginPath()
                ctx.moveTo(0, 10)
                ctx.lineTo(10, 20)
                ctx.stroke()
              })
              .width(20)
              .height(20)
          }
          .width(40)
          .height(40)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {})

          Text('r/jetpackcompose')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Column()
            .width(40)
            .height(40)
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .justifyContent(FlexAlign.Center)

        // Main scrollable content
        Scroll() {
          Column() {
            // Post Card
            this.PostCardBuilder()

            // Section header
            Text('TOP COMMENTS')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.outline)
              .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
                top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              .letterSpacing(0.5)

            // Reply list
            ForEach(this.replies, (reply: Reply) => {
              this.ReplyCardBuilder(reply)
            }, (reply: Reply) => reply.id.toString())
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom bar
      Column() {
        Row() {
          Text('Add a comment...')
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontColor(AppTokens.Colors.outline)
            .layoutWeight(1)
            .height(48)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .textAlign(TextAlign.Start)
            .textAlign(TextAlign.Start)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Button('POST')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .height(48)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .onClick(() => {})
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .position({ x: 0, y: 0 })
      .alignContent(Alignment.BottomStart)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  PostCardBuilder() {
    Row() {
      // Vote column
      Column() {
        // Upvote arrow
        Column() {
          Canvas(this.upvoteCanvasSettings)
            .onReady((ctx: CanvasRenderingContext2D) => {
              this.drawDiamond(ctx, this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
            })
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })

        // Downvote arrow
        Column() {
          Canvas(this.downvoteCanvasSettings)
            .onReady((ctx: CanvasRenderingContext2D) => {
              this.drawDiamond(ctx, this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            })
            .width(24)
            .height(24)
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1
        })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .margin({ right: AppTokens.Spacing.md })

      // Post content column
      Column() {
        this.AuthorInfoBuilder(this.post.author, this.post.timestamp)

        Text(this.post.title)
          .fontSize(AppTokens.TypographyTokens.headline.fontSize)
          .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })

        Text(this.post.body)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
          .margin({ top: AppTokens.Spacing.xs })

        Row() {
          this.InfoChipBuilder(`${this.post.commentCount} Comments`)
          this.InfoChipBuilder('Share')
        }
        .margin({ top: AppTokens.Spacing.md })
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .padding(AppTokens.Spacing.lg)
  }

  @Builder
  ReplyCardBuilder(reply: Reply) {
    Row() {
      // Vertical accent line
      Column()
        .width(2)
        .height('100%')
        .backgroundColor(reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(2)
        .margin({ right: AppTokens.Spacing.md })

      Column() {
        this.AuthorInfoBuilder(reply.author, reply.timestamp)

        Text(reply.text)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)
          .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
          .margin({ top: AppTokens.Spacing.xs })

        Row() {
          this.InfoChipBuilder(`${reply.votes} votes`)
          this.InfoChipBuilder('Reply')
        }
        .margin({ top: AppTokens.Spacing.xs })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
  }

  @Builder
  AuthorInfoBuilder(author: Author, timestamp: string) {
    Row() {
      // Avatar circle
      Stack() {
        Circle()
          .width(24)
          .height(24)
          .fill(author.avatarColor)
        Circle()
          .width(16)
          .height(16)
          .fill('rgba(0, 0, 0, 0.2)')
      }
      .width(24)
      .height(24)
      .margin({ right: AppTokens.Spacing.sm })

      Text(author.name)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .letterSpacing(0.5)
        .margin({ right: AppTokens.Spacing.sm })

      Text(timestamp)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.outline)
        .letterSpacing(0.5)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChipBuilder(text: string) {
    Text(text)
      .fontSize(AppTokens.TypographyTokens.label.fontSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
      .letterSpacing(0.5)
      .margin({ right: AppTokens.Spacing.xl })
  }

  private drawDiamond(ctx: CanvasRenderingContext2D, color: string): void {
    ctx.fillStyle = color
    ctx.beginPath()
    ctx.moveTo(12, 0)
    ctx.lineTo(24, 12)
    ctx.lineTo(12, 24)
    ctx.lineTo(0, 12)
    ctx.closePath()
    ctx.fill()
  }

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private upvoteCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private downvoteCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
}

class Author {
  name: string
  avatarColor: string

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

class Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF00E5FF'
    export const secondary: string = '#FFFF00AA'
    export const tertiary: string = '#FF76FF03'
    export const background: string = '#FF101024'
    export const surface: string = '#FF1C1C3A'
    export const surfaceVariant: string = '#FF282850'
    export const outline: string = '#FF44446A'
    export const success: string = '#FF00C853'
    export const warning: string = '#FFFFD600'
    export const error: string = '#FFFF1744'
    export const onPrimary: string = '#FF000000'
    export const onSecondary: string = '#FF000000'
    export const onTertiary: string = '#FF000000'
    export const onBackground: string = '#FFE0E0FF'
    export const onSurface: string = '#FFE0E0FF'
  }

  export namespace TypographyTokens {
    export const display = { fontSize: 28, fontWeight: FontWeight.Bold, letterSpacing: 0 }
    export const headline = { fontSize: 22, fontWeight: FontWeight.SemiBold, letterSpacing: 0 }
    export const title = { fontSize: 18, fontWeight: FontWeight.Medium, letterSpacing: 0 }
    export const body = { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 24, letterSpacing: 0 }
    export const label = { fontSize: 14, fontWeight: FontWeight.Medium, letterSpacing: 0.5 }
  }

  export namespace Shapes {
    export const small: number = 4
    export const medium: number = 8
    export const large: number = 16
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }
}
