package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size

import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "201_HoloChatDock_en"
private const val UI_TYPE = "Social Messenger"
private const val STYLE_THEME = "Dark Neon Glow"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val DENSITY_SPACING = "Compact"
private const val COMPLEXITY = "Combines FAB and BottomBar controls to handle quick actions and message composition in a dense messenger workspace."
private const val EXTRA = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts."

object AppTokens {
    object Colors {
        val primary = Color(0xFF7C3AED)
        val secondary = Color(0xFF22D3EE)
        val tertiary = Color(0xFFF97316)
        val background = Color(0xFF050714)
        val surface = Color(0xFF0F172A)
        val surfaceVariant = Color(0xFF1F2937)
        val outline = Color(0xFF334155)
        val success = Color(0xFF34D399)
        val warning = Color(0xFFFBBF24)
        val error = Color(0xFFF87171)
        val onPrimary = Color(0xFF050714)
        val onSecondary = Color(0xFF011014)
        val onTertiary = Color(0xFF110200)
        val onBackground = Color(0xFFF8FAFC)
        val onSurface = Color(0xFFE2E8F0)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 34.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.Medium, lineHeight = 28.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(12.dp)
        val medium = RoundedCornerShape(16.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
        val xxxl = 44.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 6.dp, 2.dp, 0.14f)
        val level2 = ShadowSpec(6.dp, 10.dp, 4.dp, 0.18f)
        val level3 = ShadowSpec(10.dp, 14.dp, 6.dp, 0.22f)
        val level4 = ShadowSpec(14.dp, 18.dp, 8.dp, 0.26f)
        val level5 = ShadowSpec(18.dp, 22.dp, 10.dp, 0.3f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = androidx.compose.material3.Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineLarge = AppTokens.TypographyTokens.headline,
    titleLarge = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

private val AppShapes = androidx.compose.material3.Shapes(
    small = AppTokens.Shapes.small,
    medium = AppTokens.Shapes.medium,
    large = AppTokens.Shapes.large
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = AppColorScheme, typography = AppTypography, shapes = AppShapes, content = content)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val spacing = AppTokens.Spacing
    val filters = listOf("Live", "Pinned", "Escalated", "Silent")
    var activeFilter by remember { mutableStateOf(filters.first()) }
    var draft by remember { mutableStateOf(TextFieldValue("")) }
    val threads = listOf(
        ChatThread("Orbital Finance", "Rolling sync", 5, "Need rates for Q4", true),
        ChatThread("Beacon Ops", "Docked", 0, "Switching to holo feed", false),
        ChatThread("Nova Crew", "Hotline", 2, "Uploading scan pack now", true)
    )
    Scaffold(
        modifier = Modifier.fillMaxSize(),
        containerColor = AppTokens.Colors.background,
        contentWindowInsets = WindowInsets(0),
        topBar = {
            TopAppBar(
                title = {
                    Column {
                        Text(text = "HoloChat Dock", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                        Text(text = "Dark neon bridge", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface.copy(alpha = 0.7f))
                    }
                },
                navigationIcon = {
                    TextButton(onClick = {}) {
                        Text(text = "Hub", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                    }
                },
                actions = {
                    TextButton(onClick = {}) {
                        Text(text = "Status", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = AppTokens.Colors.surface)
            )
        },
        floatingActionButton = {
            FloatingActionButton(onClick = {}, containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary, shape = AppTokens.Shapes.medium) {
                Text(text = "New", style = AppTokens.TypographyTokens.label)
            }
        },
        bottomBar = {
            Surface(color = AppTokens.Colors.surfaceVariant, tonalElevation = AppTokens.ElevationMapping.level2.elevation, shadowElevation = AppTokens.ElevationMapping.level2.elevation) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = spacing.lg, vertical = spacing.sm),
                    horizontalArrangement = Arrangement.spacedBy(spacing.sm),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    BasicTextField(
                        value = draft,
                        onValueChange = { draft = it },
                        textStyle = AppTokens.TypographyTokens.body.copy(color = AppTokens.Colors.onSurface),
                        cursorBrush = SolidColor(AppTokens.Colors.secondary),
                        modifier = Modifier
                            .weight(1f)
                            .background(AppTokens.Colors.surface, AppTokens.Shapes.medium)
                            .padding(horizontal = spacing.md, vertical = spacing.sm)
                    ) { innerTextField ->
                        Box(modifier = Modifier.fillMaxWidth()) {
                            if (draft.text.isEmpty()) {
                                Text(text = "Message dock...", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface.copy(alpha = 0.6f))
                            }
                            innerTextField()
                        }
                    }
                    Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                        Text(text = "Send", style = AppTokens.TypographyTokens.label)
                    }
                }
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .fillMaxSize()
                .verticalScroll(rememberScrollState())
                .padding(horizontal = spacing.lg, vertical = spacing.md),
            verticalArrangement = Arrangement.spacedBy(spacing.md)
        ) {
            Row(horizontalArrangement = Arrangement.spacedBy(spacing.sm)) {
                filters.forEach { label ->
                    AssistChip(
                        onClick = { activeFilter = label },
                        label = { Text(text = label, style = AppTokens.TypographyTokens.label) },
                        colors = AssistChipDefaults.assistChipColors(
                            containerColor = if (activeFilter == label) AppTokens.Colors.secondary else AppTokens.Colors.surfaceVariant,
                            labelColor = if (activeFilter == label) AppTokens.Colors.onSecondary else AppTokens.Colors.onSurface
                        ),
                        shape = AppTokens.Shapes.small
                    )
                }
            }
            StatusSummary()
            threads.forEach { thread ->
                ChatThreadCard(thread)
            }
            ActionFooter()
        }
    }
}

data class ChatThread(val name: String, val status: String, val unread: Int, val snippet: String, val isPriority: Boolean)

@Composable
fun StatusSummary() {
    val spacing = AppTokens.Spacing
    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(spacing.sm)) {
        SummaryBlock(modifier = Modifier.weight(1f), title = "Live docks", value = "12", accent = AppTokens.Colors.secondary)
        SummaryBlock(modifier = Modifier.weight(1f), title = "Escalations", value = "3", accent = AppTokens.Colors.tertiary)
        SummaryBlock(modifier = Modifier.weight(1f), title = "Queued", value = "5", accent = AppTokens.Colors.primary)
    }
}

@Composable
fun SummaryBlock(modifier: Modifier = Modifier, title: String, value: String, accent: Color) {
    Column(
        modifier = modifier
            .background(AppTokens.Colors.surface, AppTokens.Shapes.medium)
            .padding(AppTokens.Spacing.md),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)
    ) {
        Box(modifier = Modifier.size(12.dp).background(color = accent, shape = CircleShape))
        Text(text = title.uppercase(), style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface.copy(alpha = 0.7f))
        Text(text = value, style = AppTokens.TypographyTokens.display, color = accent)
    }
}

@Composable
fun ChatThreadCard(thread: ChatThread) {
    val spacing = AppTokens.Spacing
    Card(
        shape = AppTokens.Shapes.large,
        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
        border = BorderStroke(1.dp, AppTokens.Colors.outline),
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(modifier = Modifier.padding(spacing.md), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
            Row(horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically, modifier = Modifier.fillMaxWidth()) {
                Column(verticalArrangement = Arrangement.spacedBy(spacing.xs)) {
                    Text(text = thread.name, style = AppTokens.TypographyTokens.headline, color = AppTokens.Colors.onSurface)
                    Text(text = thread.status, style = AppTokens.TypographyTokens.label, color = if (thread.isPriority) AppTokens.Colors.secondary else AppTokens.Colors.onSurface.copy(alpha = 0.7f))
                }
                Box(
                    modifier = Modifier
                        .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small)
                        .padding(horizontal = spacing.sm, vertical = spacing.xs),
                    contentAlignment = Alignment.Center
                ) {
                    Text(text = if (thread.unread > 0) "+${thread.unread}" else "✓", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onSurface)
                }
            }
            Text(text = thread.snippet, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface.copy(alpha = 0.9f))
            Row(horizontalArrangement = Arrangement.spacedBy(spacing.sm)) {
                Surface(shape = AppTokens.Shapes.small, color = AppTokens.Colors.surfaceVariant) {
                    Text(
                        text = if (thread.isPriority) "Priority" else "Standard",
                        style = AppTokens.TypographyTokens.label,
                        color = AppTokens.Colors.onSurface,
                        modifier = Modifier.padding(horizontal = spacing.sm, vertical = spacing.xs)
                    )
                }
                TextButton(onClick = {}) {
                    Text(text = "Open", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                }
            }
        }
    }
}

@Composable
fun ActionFooter() {
    val spacing = AppTokens.Spacing
    Card(
        shape = AppTokens.Shapes.large,
        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surfaceVariant),
        modifier = Modifier.fillMaxWidth()
    ) {
        Column(modifier = Modifier.padding(spacing.lg), verticalArrangement = Arrangement.spacedBy(spacing.sm)) {
            Text(text = "Dock filters", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
            Row(horizontalArrangement = Arrangement.spacedBy(spacing.sm)) {
                Button(onClick = {}, shape = AppTokens.Shapes.medium) {
                    Text(text = "Calm", style = AppTokens.TypographyTokens.label)
                }
                Button(onClick = {}, shape = AppTokens.Shapes.medium, colors = androidx.compose.material3.ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.tertiary, contentColor = AppTokens.Colors.onTertiary)) {
                    Text(text = "Fire", style = AppTokens.TypographyTokens.label)
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            WindowInsetsControllerCompat(window, window.decorView).hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewRoot() {
    AppTheme {
        Surface(color = MaterialTheme.colorScheme.background) {
            RootScreen()
        }
    }
}