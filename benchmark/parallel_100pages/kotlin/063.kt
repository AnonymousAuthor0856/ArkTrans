package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.BatteryChargingFull
import androidx.compose.material.icons.filled.ElectricCar
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "105_ChargingProgress_en"
private const val UI_TYPE = "SmartHome Dashboard"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF3B82F6)
        val secondary = Color(0xFF22C55E)
        val background = Color(0xFFF5F5F4)
        val surface = Color(0xFFFFFFFF)
        val outline = Color(0xFFD4D4D8)
        val onPrimary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF111827)
        val onSurface = Color(0xFF1F2937)
        val accent = Color(0xFFF59E0B)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 20.dp
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    secondary = AppTokens.Colors.secondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    outline = AppTokens.Colors.outline
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        content = content
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var progress by remember { mutableStateOf(0.45f) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(
                        "Charging Progress",
                        style = MaterialTheme.typography.displayLarge,
                        color = AppTokens.Colors.onBackground
                    )
                },
                navigationIcon = {
                    Icon(
                        Icons.Filled.ElectricCar,
                        contentDescription = null,
                        tint = AppTokens.Colors.primary,
                        modifier = Modifier.padding(start = 8.dp)
                    )
                },
                actions = {
                    IconButton(onClick = {}) {
                        Icon(Icons.Filled.Settings, contentDescription = "Settings", tint = AppTokens.Colors.accent)
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(
                    containerColor = AppTokens.Colors.surface
                )
            )
        },
        containerColor = AppTokens.Colors.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Icon(
                Icons.Filled.BatteryChargingFull,
                contentDescription = null,
                tint = AppTokens.Colors.primary,
                modifier = Modifier.size(72.dp)
            )
            Text(
                "${(progress * 100).toInt()}%",
                style = MaterialTheme.typography.displayLarge.copy(fontSize = 40.sp),
                color = AppTokens.Colors.onBackground
            )
            LinearProgressIndicator(
                progress = progress,
                modifier = Modifier
                    .fillMaxWidth(0.8f)
                    .height(14.dp)
                    .border(1.dp, AppTokens.Colors.outline, CircleShape),
                color = AppTokens.Colors.primary,
                trackColor = AppTokens.Colors.surface
            )

            Button(
                onClick = {
                    progress += 0.1f
                    if (progress > 1f) progress = 0f
                },
                shape = CircleShape,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary)
            ) {
                Text("Simulate Charge", color = AppTokens.Colors.onPrimary)
            }

            Text(
                if (progress < 1f) "Charging..." else "Fully Charged!",
                style = MaterialTheme.typography.headlineMedium,
                color = if (progress < 1f) AppTokens.Colors.primary else AppTokens.Colors.secondary
            )
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        setContent {
            AppTheme { Surface(color = MaterialTheme.colorScheme.background) { RootScreen() } }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF5F5F4)
@Composable
fun PreviewRoot() {
    AppTheme { RootScreen() }
}
