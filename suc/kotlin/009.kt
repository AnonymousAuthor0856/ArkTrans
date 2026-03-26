package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "003VideoPlayeren"
private const val UI_TYPE = "Media"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1E3A8A)
        val secondary = Color(0xFF3B82F6)
        val background = Color(0xFF0F172A)
        val surface = Color(0xFF1E293B)
        val surfaceVariant = Color(0xFF334155)
        val outline = Color(0xFF475569)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFFF8FAFC)
        val onSurface = Color(0xFFE2E8F0)
    }
    object Typography {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = CircleShape
        val medium = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val sm = 8.dp; val md = 12.dp; val lg = 16.dp; val xl = 24.dp; val xxl = 32.dp
    }
    data class Shadow(val elevation: Dp)
    object Elevation { val level1 = Shadow(0.dp) }
}

private val Scheme003 = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val Type003 = Typography(
    displayLarge = AppTokens.Typography.display,
    titleMedium = AppTokens.Typography.title,
    bodyMedium = AppTokens.Typography.body,
    labelMedium = AppTokens.Typography.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = Scheme003, typography = Type003, content = content)
}

data class VideoState(val title: String, val currentTime: Float, val totalTime: Float, val playing: Boolean, val fullscreen: Boolean)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var state by remember {
        mutableStateOf(
            VideoState(
                title = "Journey through the Skies",
                currentTime = 95f,
                totalTime = 240f,
                playing = false,
                fullscreen = false
            )
        )
    }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            if (!state.fullscreen) {
                CenterAlignedTopAppBar(
                    title = { Text("Video Player", style = MaterialTheme.typography.titleMedium) },
                    colors = TopAppBarDefaults.centerAlignedTopAppBarColors(
                        containerColor = MaterialTheme.colorScheme.background
                    )
                )
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(MaterialTheme.colorScheme.background),
            verticalArrangement = Arrangement.SpaceBetween,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
                    .background(MaterialTheme.colorScheme.surfaceVariant, AppTokens.Shapes.medium),
                contentAlignment = Alignment.Center
            ) {
                Text("Video Surface", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
            }
            Column(
                modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.xl),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            ) {
                Text(state.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                Slider(
                    value = state.currentTime / state.totalTime,
                    onValueChange = { p -> state = state.copy(currentTime = p * state.totalTime) },
                    colors = SliderDefaults.colors(
                        thumbColor = MaterialTheme.colorScheme.primary,
                        activeTrackColor = MaterialTheme.colorScheme.primary,
                        inactiveTrackColor = MaterialTheme.colorScheme.outline
                    )
                )
                Row(
                    Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(formatTime(state.currentTime), style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    Text(formatTime(state.totalTime), style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                }
                Row(
                    Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    FilledTonalButton(
                        onClick = { state = state.copy(currentTime = (state.currentTime - 10f).coerceAtLeast(0f)) },
                        shape = AppTokens.Shapes.medium
                    ) { Text("−10s", style = MaterialTheme.typography.titleMedium) }
                    FilledIconButton(
                        onClick = { state = state.copy(playing = !state.playing) },
                        colors = IconButtonDefaults.filledIconButtonColors(
                            containerColor = MaterialTheme.colorScheme.primary,
                            contentColor = MaterialTheme.colorScheme.onPrimary
                        ),
                        modifier = Modifier.size(72.dp)
                    ) { Text(if (state.playing) "II" else "▶", style = MaterialTheme.typography.displayLarge) }
                    FilledTonalButton(
                        onClick = { state = state.copy(currentTime = (state.currentTime + 30f).coerceAtMost(state.totalTime)) },
                        shape = AppTokens.Shapes.medium
                    ) { Text("+30s", style = MaterialTheme.typography.titleMedium) }
                }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    FilterChip(
                        selected = state.fullscreen,
                        onClick = { state = state.copy(fullscreen = !state.fullscreen) },
                        label = { Text(if (state.fullscreen) "Exit Fullscreen" else "Fullscreen") },
                        colors = FilterChipDefaults.filterChipColors(
                            selectedContainerColor = MaterialTheme.colorScheme.secondary.copy(alpha = 0.2f)
                        )
                    )
                }
            }
        }
    }
}

private fun formatTime(sec: Float): String {
    val total = sec.toInt().coerceAtLeast(0)
    val m = total / 60
    val s = total % 60
    return "%d:%02d".format(m, s)
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val c = WindowInsetsControllerCompat(window, window.decorView)
        c.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        c.hide(WindowInsetsCompat.Type.systemBars())
        setContent { AppTheme { Surface(color = MaterialTheme.colorScheme.background) { RootScreen() } } }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val c = WindowInsetsControllerCompat(window, window.decorView)
            c.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            c.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFF0F172A)
@Composable
fun PreviewScreen() { AppTheme { RootScreen() } }