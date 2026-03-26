package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
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
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.KeyboardArrowDown
import androidx.compose.material.icons.filled.KeyboardArrowUp
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 1. Enable Edge-to-Edge
        enableEdgeToEdge()

        // 2. Hide System Bars (Immersive Mode)
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Apply a simple material theme
            MaterialTheme(
                colorScheme = MaterialTheme.colorScheme.copy(
                    background = Color.White,
                    surface = Color.White,
                    onBackground = Color.Black,
                    onSurface = Color.Black,
                    primary = Color.Black // Monochrome/Minimalist style
                )
            ) {
                // Ensure system bars stay hidden on recompositions if needed
                SideEffect {
                    windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
                }
                ThermostatScreen()
            }
        }
    }
}

@Composable
fun ThermostatScreen() {
    // State for UI interactivity
    var currentTemp by remember { mutableIntStateOf(22) }
    var targetTemp by remember { mutableIntStateOf(24) }
    var isPowerOn by remember { mutableStateOf(true) }
    var selectedMode by remember { mutableStateOf("Cool") }

    Scaffold(
        containerColor = Color.White,
        topBar = {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 24.dp, vertical = 24.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = { }) {
                    Icon(
                        imageVector = Icons.Default.Menu,
                        contentDescription = "Menu",
                        tint = Color.Gray
                    )
                }
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Text(
                        text = "LIVING ROOM",
                        style = MaterialTheme.typography.labelMedium,
                        color = Color.Gray,
                        fontWeight = FontWeight.Bold,
                        letterSpacing = 2.sp
                    )
                    if (isPowerOn) {
                        Text(
                            text = "Active",
                            style = MaterialTheme.typography.labelSmall,
                            color = Color(0xFF4CAF50) // Material Green
                        )
                    } else {
                        Text(
                            text = "Off",
                            style = MaterialTheme.typography.labelSmall,
                            color = Color.LightGray
                        )
                    }
                }
                IconButton(onClick = { }) {
                    Icon(
                        imageVector = Icons.Default.Settings,
                        contentDescription = "Settings",
                        tint = Color.Gray
                    )
                }
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.SpaceBetween
        ) {

            Spacer(modifier = Modifier.height(10.dp))

            // --- Main Temperature Control ---
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier.size(280.dp)
            ) {
                // decorative circle
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    shape = CircleShape,
                    color = Color.White,
                    border = BorderStroke(1.dp, Color(0xFFEEEEEE)),
                    shadowElevation = 0.dp
                ) {}

                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Text(
                        text = "$targetTemp°",
                        style = MaterialTheme.typography.displayLarge.copy(
                            fontSize = 96.sp,
                            fontWeight = FontWeight.Light
                        ),
                        color = if (isPowerOn) Color.Black else Color.LightGray
                    )
                    Text(
                        text = "CURRENT: $currentTemp°",
                        style = MaterialTheme.typography.bodyMedium,
                        color = Color.Gray
                    )
                }

                // Buttons positioned absolutely within the box roughly
                if (isPowerOn) {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(20.dp),
                        contentAlignment = Alignment.CenterEnd
                    ) {
                        IconButton(
                            onClick = { targetTemp++ },
                            modifier = Modifier
                                .background(Color(0xFFF5F5F5), CircleShape)
                                .size(48.dp)
                        ) {
                            Icon(Icons.Default.Add, contentDescription = "Increase")
                        }
                    }

                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(20.dp),
                        contentAlignment = Alignment.CenterStart
                    ) {
                        // Using arrow down as "Minus" equivalent since strict icon set
                        IconButton(
                            onClick = { targetTemp-- },
                            modifier = Modifier
                                .background(Color(0xFFF5F5F5), CircleShape)
                                .size(48.dp)
                        ) {
                            Icon(Icons.Default.KeyboardArrowDown, contentDescription = "Decrease")
                        }
                    }
                }
            }

            // --- Mode Selection ---
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Text(
                    text = "MODE",
                    style = MaterialTheme.typography.labelSmall,
                    color = Color.Gray,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                Row(
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    ModeButton(
                        icon = Icons.Default.Home,
                        label = "Auto",
                        isSelected = selectedMode == "Auto",
                        enabled = isPowerOn,
                        onClick = { selectedMode = "Auto" }
                    )
                    ModeButton(
                        icon = Icons.Default.Refresh, // Simulating Fan
                        label = "Fan",
                        isSelected = selectedMode == "Fan",
                        enabled = isPowerOn,
                        onClick = { selectedMode = "Fan" }
                    )
                    ModeButton(
                        icon = Icons.Default.Star, // Simulating Cool/Eco
                        label = "Cool",
                        isSelected = selectedMode == "Cool",
                        enabled = isPowerOn,
                        onClick = { selectedMode = "Cool" }
                    )
                }
            }

            // --- Info Cards ---
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                InfoCard(
                    title = "Humidity",
                    value = "45%",
                    icon = Icons.Default.Info, // Generic info icon
                    modifier = Modifier.weight(1f)
                )
                InfoCard(
                    title = "Energy",
                    value = "12 kWh",
                    icon = Icons.Default.KeyboardArrowUp, // Simulating usage up
                    modifier = Modifier.weight(1f)
                )
            }

            // --- Power Switch ---
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 40.dp)
                    .background(Color(0xFFF9F9F9), RoundedCornerShape(16.dp))
                    .padding(horizontal = 20.dp, vertical = 16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "Master Power",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold
                    )
                    Text(
                        text = if (isPowerOn) "System is running" else "System is off",
                        style = MaterialTheme.typography.bodySmall,
                        color = Color.Gray
                    )
                }
                Switch(
                    checked = isPowerOn,
                    onCheckedChange = { isPowerOn = it },
                    colors = SwitchDefaults.colors(
                        checkedThumbColor = Color.White,
                        checkedTrackColor = Color.Black,
                        uncheckedThumbColor = Color.Gray,
                        uncheckedTrackColor = Color.LightGray
                    )
                )
            }
        }
    }
}

@Composable
fun ModeButton(
    icon: ImageVector,
    label: String,
    isSelected: Boolean,
    enabled: Boolean,
    onClick: () -> Unit
) {
    val containerColor = if (isSelected && enabled) Color.Black else Color.White
    val contentColor = if (isSelected && enabled) Color.White else if (enabled) Color.Black else Color.LightGray
    val borderColor = if (isSelected && enabled) Color.Black else Color(0xFFE0E0E0)

    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Button(
            onClick = onClick,
            enabled = enabled,
            shape = CircleShape,
            colors = ButtonDefaults.buttonColors(
                containerColor = containerColor,
                contentColor = contentColor,
                disabledContainerColor = Color(0xFFF5F5F5),
                disabledContentColor = Color.LightGray
            ),
            border = if (!isSelected) BorderStroke(1.dp, borderColor) else null,
            modifier = Modifier.size(60.dp),
            contentPadding = PaddingValues(0.dp)
        ) {
            Icon(
                imageVector = icon,
                contentDescription = label,
                modifier = Modifier.size(24.dp)
            )
        }
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = if (enabled) Color.Gray else Color.LightGray
        )
    }
}

@Composable
fun InfoCard(
    title: String,
    value: String,
    icon: ImageVector,
    modifier: Modifier = Modifier
) {
    Card(
        modifier = modifier,
        shape = RoundedCornerShape(16.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF9F9F9)),
        border = BorderStroke(1.dp, Color(0xFFF0F0F0))
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = Color.Gray,
                modifier = Modifier.size(20.dp)
            )
            Text(
                text = value,
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = title,
                style = MaterialTheme.typography.bodySmall,
                color = Color.Gray
            )
        }
    }
}

@Preview(showBackground = true, widthDp = 360, heightDp = 800)
@Composable
fun AppPreview() {
    MaterialTheme(
        colorScheme = MaterialTheme.colorScheme.copy(
            background = Color.White,
            surface = Color.White
        )
    ) {
        ThermostatScreen()
    }
}