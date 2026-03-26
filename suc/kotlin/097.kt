package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.KeyboardArrowDown
import androidx.compose.material.icons.filled.KeyboardArrowUp
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import kotlin.math.cos
import kotlin.math.sin

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Constraint: Immersive Mode & Hide System Navigation Bars
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Apply a simple side effect to keep bars hidden if the view redraws significantly
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            ClimateControllerApp()
        }
    }
}

// --- Colors ---
val PureWhite = Color(0xFFFFFFFF)
val TextBlack = Color(0xFF1C1C1E)
val TextGray = Color(0xFF8E8E93)
val AccentBlue = Color(0xFF007AFF)
val SoftGrayBg = Color(0xFFF2F2F7)
val ActiveOrange = Color(0xFFFF9500)

@Composable
fun ClimateControllerApp() {
    // Constraint: Global Pure White Background
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = PureWhite
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            HeaderSection()

            Spacer(modifier = Modifier.height(40.dp))

            TemperatureDialSection()

            Spacer(modifier = Modifier.height(40.dp))

            ControlGridSection()
        }
    }
}

@Composable
fun HeaderSection() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(top = 16.dp), // Extra padding for immersive status bar area
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(onClick = { /* No op */ }) {
            Icon(
                imageVector = Icons.Default.Menu,
                contentDescription = "Menu",
                tint = TextBlack
            )
        }

        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = "LIVING ROOM",
                style = MaterialTheme.typography.labelMedium,
                color = TextGray,
                letterSpacing = 2.sp,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = "Connected",
                style = MaterialTheme.typography.bodySmall,
                color = AccentBlue
            )
        }

        IconButton(onClick = { /* No op */ }) {
            Icon(
                imageVector = Icons.Default.Settings,
                contentDescription = "Settings",
                tint = TextBlack
            )
        }
    }
}

@Composable
fun TemperatureDialSection() {
    var targetTemp by remember { mutableFloatStateOf(21.5f) }
    var isActive by remember { mutableStateOf(true) }

    // Logic to clamp temperature
    fun adjustTemp(delta: Float) {
        val newTemp = (targetTemp + delta).coerceIn(16.0f, 30.0f)
        targetTemp = (Math.round(newTemp * 10) / 10.0).toFloat()
    }

    Column(
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier.size(280.dp)
        ) {
            // Background Circle
            Canvas(modifier = Modifier.size(240.dp)) {
                drawCircle(
                    color = SoftGrayBg,
                    radius = size.minDimension / 2,
                    style = Stroke(width = 40f)
                )
            }

            // Animated Arc Indicator
            val progress = (targetTemp - 16f) / (30f - 16f) // Normalize 0..1
            val animatedProgress by animateFloatAsState(
                targetValue = progress,
                animationSpec = tween(durationMillis = 500),
                label = "TempArc"
            )

            Canvas(modifier = Modifier.size(240.dp)) {
                val strokeWidth = 40f
                val startAngle = 135f
                val sweepAngle = 270f * animatedProgress

                // Draw arc
                drawArc(
                    color = if (isActive) AccentBlue else TextGray,
                    startAngle = startAngle,
                    sweepAngle = sweepAngle,
                    useCenter = false,
                    style = Stroke(width = strokeWidth, cap = StrokeCap.Round),
                    size = Size(size.width, size.height)
                )

                // Draw knob indicator
                val angleInRadians = Math.toRadians((startAngle + sweepAngle).toDouble())
                val radius = (size.width / 2)
                val center = Offset(size.width / 2, size.height / 2)
                val knobPos = Offset(
                    x = (center.x + radius * cos(angleInRadians)).toFloat(),
                    y = (center.y + radius * sin(angleInRadians)).toFloat()
                )

                drawCircle(
                    color = PureWhite,
                    radius = 16f,
                    center = knobPos
                )
                drawCircle(
                    color = if (isActive) AccentBlue else TextGray,
                    radius = 10f,
                    center = knobPos
                )
            }

            // Center Text
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text(
                    text = "${targetTemp}°",
                    style = MaterialTheme.typography.displayMedium,
                    fontWeight = FontWeight.Bold,
                    color = if (isActive) TextBlack else TextGray
                )
                Text(
                    text = if (isActive) "COOLING" else "OFF",
                    style = MaterialTheme.typography.labelLarge,
                    color = TextGray,
                    fontWeight = FontWeight.Medium
                )
            }
        }

        Spacer(modifier = Modifier.height(32.dp))

        // Temp Controls
        Row(
            horizontalArrangement = Arrangement.spacedBy(32.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            RoundControlButton(
                icon = Icons.Default.KeyboardArrowDown,
                onClick = { adjustTemp(-0.5f) },
                enabled = isActive
            )

            // Power Switch Logic
            Switch(
                checked = isActive,
                onCheckedChange = { isActive = it },
                colors = SwitchDefaults.colors(
                    checkedThumbColor = PureWhite,
                    checkedTrackColor = TextBlack,
                    uncheckedThumbColor = TextGray,
                    uncheckedTrackColor = SoftGrayBg,
                    uncheckedBorderColor = Color.Transparent
                )
            )

            RoundControlButton(
                icon = Icons.Default.KeyboardArrowUp,
                onClick = { adjustTemp(0.5f) },
                enabled = isActive
            )
        }
    }
}

@Composable
fun RoundControlButton(
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    onClick: () -> Unit,
    enabled: Boolean
) {
    Box(
        modifier = Modifier
            .size(56.dp)
            .clip(CircleShape)
            .background(if (enabled) SoftGrayBg else Color(0xFFF9F9F9))
            .clickable(enabled = enabled, onClick = onClick)
            .border(1.dp, if (enabled) Color.Transparent else Color(0xFFEEEEEE), CircleShape),
        contentAlignment = Alignment.Center
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = if (enabled) TextBlack else Color(0xFFD1D1D6),
            modifier = Modifier.size(28.dp)
        )
    }
}

@Composable
fun ControlGridSection() {
    Column(modifier = Modifier.fillMaxWidth()) {
        Text(
            text = "QUICK ACTIONS",
            style = MaterialTheme.typography.labelSmall,
            fontWeight = FontWeight.Bold,
            color = TextGray,
            modifier = Modifier.padding(bottom = 16.dp)
        )

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            QuickActionCard(
                modifier = Modifier.weight(1f),
                icon = Icons.Default.Refresh,
                label = "Fan Speed",
                status = "Auto"
            )
            QuickActionCard(
                modifier = Modifier.weight(1f),
                icon = Icons.Default.Favorite,
                label = "Eco Mode",
                status = "On",
                isActive = true
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            QuickActionCard(
                modifier = Modifier.weight(1f),
                icon = Icons.Default.Info, // Generic icon as timer
                label = "Timer",
                status = "Set 2h"
            )
            QuickActionCard(
                modifier = Modifier.weight(1f),
                icon = Icons.Default.Home,
                label = "Away",
                status = "Off"
            )
        }
    }
}

@Composable
fun QuickActionCard(
    modifier: Modifier = Modifier,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    label: String,
    status: String,
    isActive: Boolean = false
) {
    Card(
        modifier = modifier.height(100.dp),
        colors = CardDefaults.cardColors(
            containerColor = if (isActive) TextBlack else SoftGrayBg
        ),
        shape = RoundedCornerShape(20.dp),
        elevation = CardDefaults.cardElevation(0.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.SpaceBetween,
            horizontalAlignment = Alignment.Start
        ) {
            Icon(
                imageVector = icon,
                contentDescription = label,
                tint = if (isActive) PureWhite else TextBlack,
                modifier = Modifier.size(24.dp)
            )

            Column {
                Text(
                    text = label,
                    style = MaterialTheme.typography.labelMedium,
                    fontWeight = FontWeight.SemiBold,
                    color = if (isActive) PureWhite else TextBlack
                )
                Text(
                    text = status,
                    style = MaterialTheme.typography.bodySmall,
                    color = if (isActive) TextGray else TextGray
                )
            }
        }
    }
}

@Preview(showBackground = true, widthDp = 360, heightDp = 800)
@Composable
fun AppPreview() {
    ClimateControllerApp()
}